WITH usage_summary AS (
    SELECT
        u.account_id,
        SUM(CASE
            WHEN u.event_date >= r.recent_30_day_start
            AND u.event_date <= r.reporting_date
            THEN 1 ELSE 0
        END) AS last_30_day_usage,
        SUM(CASE
            WHEN u.event_date >= r.recent_60_day_start
            AND u.event_date < r.recent_30_day_start
            THEN 1 ELSE 0
        END) AS previous_30_day_usage
    FROM usage_events AS u
    CROSS JOIN reporting_context AS r
    GROUP BY u.account_id
),
support_summary AS (
    SELECT
        s.account_id,
        COUNT(s.ticket_id) AS recent_high_priority_tickets
    FROM support_tickets AS s
    CROSS JOIN reporting_context AS r
    WHERE s.created_date >= r.recent_30_day_start
        AND s.created_date <= r.reporting_date
        AND s.priority = 'high'
    GROUP BY s.account_id
)
SELECT
    a.account_id,
    a.account_name,
    u.last_30_day_usage,
    u.previous_30_day_usage,
    ROUND(
        100.0 * (u.previous_30_day_usage - u.last_30_day_usage)
        / u.previous_30_day_usage, 2
    ) AS percent_drop,
    s.recent_high_priority_tickets,
    'Significant usage drop and recent high-priority support tickets'
        AS risk_reason
FROM accounts AS a
JOIN usage_summary AS u
    ON a.account_id = u.account_id
JOIN support_summary AS s
    ON a.account_id = s.account_id
WHERE a.account_status = 'active'
    AND u.previous_30_day_usage > 0
    AND u.last_30_day_usage <= u.previous_30_day_usage * 0.5
    AND s.recent_high_priority_tickets > 0
ORDER BY percent_drop DESC, recent_high_priority_tickets DESC;