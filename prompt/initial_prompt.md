Task:
Write a SQLite query to identify active SaaS accounts that may be at risk of churn based on a 50% or greater drop in product usage and recent support ticket activity.

Schema:
Use the accounts, usage_events, and support_tickets tables.
Join tables using account_id.
The usage_events table includes event_id, account_id, event_date, event_type, user_id, and feature_name.
The support_tickets table includes ticket_id, account_id, created_date, ticket_status, priority, and issue_category.
The accounts table includes account_id, account_name, plan_type, industry, account_status, and created_date.
Use reporting_context.recent_30_day_start and reporting_context.recent_60_day_start for fixed date boundaries.

Constraints:
Count usage events in the last 30 days.
Count usage events in the previous 30 days.
Flag active accounts where last 30 day usage is 50% or more lower than previous 30 day usage.
Count high-priority support tickets created in the last 30 days.
Only include accounts with at least one high-priority support ticket.
Only include accounts where account_status = 'active'.
Use only columns that exist in the schema.

Output:
Return account_id, account_name, last_30_day_usage, previous_30_day_usage, percent_drop, recent_high_priority_tickets, and risk_reason.