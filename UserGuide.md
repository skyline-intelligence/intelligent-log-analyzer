# User Guide

This guide provides step-by-step instructions for using the Intelligent Log Analyzer plugin after installation.

## 1. Configure Loki Query Addresses

After enabling the analyzer plugin, configure the Loki log query addresses on the Configuration page:

In the configuration page, set up the addresses for querying Loki error logs. Authentication methods include username+password and token.

- **Example Loki query address**: `https://loki.grafana.vzone1.kr.couwatch.net/api/ds/query?ds_type=loki`

## 2. Configure Role Settings

After configuring the Loki log query addresses, go to the **Roles Setting** page to add roles that need to be monitored:

- The order of roles corresponds to the display order on the monitoring page
- To adjust the display order of roles, delete the role and re-add it in the desired position

## 3. Error Details Panel - Keywords Grouping

In the Error details panel, when an error category has more than 10 keywords, a **"Keywords Grouping"** button will appear on the far left of the error entry.

- Click this button to enter the Keywords Grouping page
- The system will pass the Error information and the first keyword's details to this page

### 3.1 Custom Groovy Script Processing

Users can add custom Groovy Scripts in the **"Groovy Script"** box to customize keyword processing:

- **Input parameters**: `(String keyword, String rawMessage)`
  - `keyword`: The current system-processed result
  - `rawMessage`: The complete error message
- **Return value**: `String keyword`
- Users can either refine the system-processed keyword or extract a new keyword from the rawMessage

**Example code** - Split keyword by ":" and return the substring before ":":

```groovy
def process(String keyword, String rawMessage) {
    int end = keyword.indexOf(":");
    def result = keyword.substring(0, end);
    return result.trim();
}
```

### 3.2 Script Validation
After adding the "Groovy Script" , users can click the Validate button to verify the script:

- If validation passes : The processed keyword result will appear to the right of the button
- If validation fails : Error messages will be displayed
### 3.3 Save Keywords Grouping Rules
After successful validation, users can click the Save button to save the keywords grouping rule:

- The rule takes effect immediately after saving
- Future error messages of the same type will be processed using the custom rule
## 4. Edit Existing Keywords Grouping Rules
After adding custom "Groovy Scripts" , users can later edit these rules on the "Keywords Grouping" page:

- Note : When editing rules from the "Keywords Grouping" page, users will need to manually input keywords and rawMessage for validation

## Quick Reference
| Action | Location | Description |
|--------|----------|-------------|
| Configure Loki | Configuration Page | Set up Loki query addresses and authentication |
| Add Roles | Roles Setting Page | Add and order monitoring roles |
| Keywords Grouping | Error Details Panel | Customize keyword processing with Groovy scripts |
| Edit Rules | Keywords Grouping Page | Modify existing grouping rules |

## Support
For additional support or troubleshooting, please refer to the main README.md file or contact your system administrator.