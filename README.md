My original workflow was:
I asked the AI to identify at-risk accounts using usage and support ticket data.

The main issue I found was:
The first SQL did not compare last 30 day usage to previous 30 day usage, and it risked overcounting because it joined usage_events and support_tickets before aggregation.

I refined the workflow by:
Adding clearer instructions for separate usage and ticket summaries, defining the time windows, and requiring only valid schema columns.

The revised SQL is more reliable because:
It uses valid columns, compares the correct time periods, filters to active accounts, applies the 50% drop threshold, avoids row multiplication, and applies the at-risk definition more directly.

In future AI-assisted SQL work, I will:
Define the business rule first, validate the schema, inspect joins carefully, and refine the prompt before trusting the SQL output.