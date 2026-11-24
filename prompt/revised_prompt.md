Completed Revised Prompt

Task:
Write a SQLite query to identify active SaaS accounts that may be at risk of churn based on a 50% or greater usage drop and recent high-priority support activity.

Schema:
Use accounts, usage_events, and support_tickets.
Join usage and support summaries to accounts using account_id.
Use only columns that exist in the schema.

Constraints:
Create one summary for usage events:
- last_30_day_usage = count of usage_events where event_date is within the last 30 days
- previous_30_day_usage = count of usage_events where event_date is between 31 and 60 days ago

Create a separate summary for support tickets:
- recent_high_priority_tickets = count of support_tickets where created_date is within the last 30 days and priority = 'high'

Only return accounts where:
- last_30_day_usage is 50% or more lower than previous_30_day_usage
- recent_high_priority_tickets is greater than 0
- account_status = 'active'

Output:
Return account_id, account_name, last_30_day_usage, previous_30_day_usage, percent_drop, recent_high_priority_tickets, and risk_reason.
Avoid multiplying rows by aggregating usage_events and support_tickets separately before joining them to accounts.