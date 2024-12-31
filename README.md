<h1><span style="color:#2d7eea">Google Cloud Cortex Framework for SAP v2</span></h1>
<h2><span style="color:#ff0000">This is a BETA version that is still undergoing development. Content may change.</span></h2>
This updated version, which incorporates Looker Best Practices, simplifies content and enhances both readability and reusability. It will supersede the original Cortex SAP block once content parity is achieved. As of now, only a partial set of dashboards is available.


<h2><span style="color:#2d7eea">What does this Looker Block do for me?</span></h2>

Gain faster insights into your Order to Cash, Finance, and Inventory data with these Dashboards and Explores based on the SAP Cortex Data Foundation. Leverage or customize this Looker model to:
* Identify trends and patterns in your data
* Spot potential problems early on
* Make better decisions faster

<h2><span style="color:#2d7eea">Included Dashboards by Subject Area</span></h2>

<h3> Order to Cash Operational Reports</h3>


| **Dashboard** | **Description**                            |
|---------------|--------------------------------------------|
| **Order Status** | Overview of order-related metrics, including order volume, a breakdown of the order flow status from booking to billing, and an analysis of order status. |
| **Sales Performance** | Insights into top sales performers including items, categories, customers, business units, and order sources. |
| **Order Fulfillment** | Tracks fulfillment performance over time, highlighting items with the longest average order cycle time and those experiencing fulfillment challenges. |
| **Order Details** | View details of a subset of sales orders satisfying a set of filter criteria.  For example, see details of all blocked orders in a given time frame. |
| **Billing & Pricing** | Overview of invoice volume and amounts including monthly trends. Also highlights customers with highest price adjustments. |
| **Billing Details** | View details of a subset of invoices satisfying a set of filter criteria.  For example, see details of all open invoices in a given time frame. |


<h3>Finance Reports</h3>


| **Dashboard** | **Description**                            |
|---------------|--------------------------------------------|
| **Balance Sheet** | View the balance sheet as of a selected fiscal period. Compare it to the same period last year, the previous fiscal period, or a different fiscal period. And display multiple levels of the selected hierarchy for a user-specified chart of accounts and company. Two dashboards using different table styles are included. If using this block with the SAP Finance test harness data, only company code C006 balances to zero. This is expected.<br>Note: Balance Sheet only works with [Cortex Framework 5.3](https://cloud.google.com/cortex/docs/release-notes#release_53) and later.|
| **Income Statement** | View the income statement for selected fiscal periods, individually or combined. Compare the timeframe to the same timeframe a year ago or the preceding fiscal timeframe, and display multiple levels of the GL Account hierarchy. Two dashboards using different table styles are included. <br>If using this block with SAP Finance test harness data, company code C006 provides the best illustration of Income Statement.<br>Note: Income Statement only works with [Cortex Framework 5.4](https://cloud.google.com/cortex/docs/release-notes#release_54) and later.|



<h2><span style="color:#2d7eea">Required Data</span></h2>

Get the required BigQuery datasets for this block by following the installation instructions for [Google Cloud Cortex Framework](https://github.com/GoogleCloudPlatform/cortex-data-foundation).

<h2><span style="color:#2d7eea">Installation Instructions</span></h2>

Manually install this LookML Model following one of the options below.

<h4><span style="color:#2d7eea">Option A: Install through Looker Marketplace from a GIT URL</span></h4>

The [Looker Marketplace](https://cloud.google.com/looker/docs/marketplace) is a central location within Looker for finding, deploying, and managing Looker Blocks, applications, visualizations, and plug-ins. To install through Looker Marketplace from a Git URL, follow these steps:

1. Go to your Looker instance.
2. Click the **Marketplace** button on the Looker menu bar.
3. From the Marketplace menu, select the **Manage** option.
4. On the **Manage** page, select the three-dot **Options** menu.
5. Select **Install via Git URL** button.
6. Enter the URL and commit SHA of this repository.
7. Click **Install**.
8. Agree and Continue at the terms and conditions dialog.
9. Enter the required parameters for this block:
     Connection Name
     Project ID
     Reporting Dataset
     Client ID
     SAP Sign Change for Income Statement Reports (yes or no)
10. Click Install.

For more information, see the Looker documentation for [Installing a Tool from a Git URL](https://cloud.google.com/looker/docs/marketplace#installing_a_tool_from_a_git_url).


<h4><span style="color:#2d7eea">Option B: Install by forking the repository</span></h4>

Forking the repository gives you the greatest flexibility to edit and customize the block.
To install Looker blocks by forking the repository, follow these steps:

1. **Fork the GitHub repository**:

   a. Navigate to the GitHub repository of this block.
   
   b. Click **Fork** in the top-right corner of the repository.
   
   c. Create a fork with your username. This creates a copy of the repository in your GitHub account.

3. **Create a blank LookML project**:
   
   a. Verify that you are in [Development Mode](https://cloud.google.com/looker/docs/dev-mode-prod-mode#switching_in_and_out_of_development_mode).
   
   b. Select **Manage LookML Projects** from the **Develop** menu.
   
   c. From the **LookML Projects** page, select **New LookML Project** to open the **New Project** page.
   
   d. On the **New Project** page, specify the options for your project:
      - **Project Name**: Give your project a name. Choose the project name carefully and consider it a permanent ID for the project, since Looker uses the project name for unique identification in different processes.
      - **Starting Point**: Choose Blank Project.
   
   e. Select Create Project. Looker creates the project and opens it in the [Looker IDE](https://cloud.google.com/looker/docs/looker-ide).

   For more information, see the original Looker documentation for [Creating a blank project](https://cloud.google.com/looker/docs/create-projects#creating_a_blank_project).

5. **Connect the new LookML project to the forked repository**: Follow the steps in the Looker documentation, [Setting up and testing a Git connection](https://cloud.google.com/looker/docs/setting-up-git-connection).

6. **Update the values of constants in the manifest.lkml file**:
   a. Open the `manifest.lkml` file in your forked repository in Looker.
   b. Locate the constants section and update the values as described in the Required parameters section.

7. **Commit and deploy changes to production.** With the Looker project based on your forked repository, you can customize the LookML to fit your unique business needs. Follow the steps in [Getting your changes to production](https://cloud.google.com/looker/docs/version-control-and-deploying-changes#getting_your_changes_to_production).

With the Looker project based on your forked repository, you can customize the LookML to fit your unique business needs.

<h2><span style="color:#2d7eea"> Required Parameters</span></h2>
> ⚠️ These required values are configured during the Marketplace Installation process, or if this Block was installed from a forked Git repository, you will update the values for these constants in the `manifest.lkml` file for the project.


| **Required Parameter** | **Label**                            | **Description** |
|----------------------------------|--------------------------------------|---------------|
| **Connection Name** | Name of the connection      | The BigQuery connection name that allows Looker to query the Cortex REPORTING dataset.|
| **GCP Project ID** | Project ID  | The Google Cloud project where the reporting dataset resides in BigQuery. For more information, see [Identifying projects](https://cloud.google.com/resource-manager/docs/creating-managing-projects#identifying_projects).|
| **Reporting Dataset** | Name of the dataset for Cortex reporting | The deployed Cortex Data Framework REPORTING dataset where the SAP views reside within the Google Cloud BigQuery project. Depending on the deployment settings for the Cortex Data Framework, this dataset name would typically be of the pattern ending with _REPORTING.|
| **Client ID** | SAP Client number (MANDT) | The SAP Client number (mandt) to use for Reporting. |
| **Sign Change** | **Yes** or **No** | For Profit and Loss/Income Statement reporting, revenue is generally displayed in the general ledger as a negative number, which indicates a credit. By setting Sign Change value to **Yes**, it's displayed as a positive number in income statement reports.|

<h2><span style="color:#2d7eea">Persistent Derived Tables required</span></h2>

The BigQuery connection used for this block must have [Persistent Derived Tables](https://cloud.google.com/looker/docs/derived-tables#persistent_derived_tables) enabled. For more information, see [Enabling PDTs on a Connection](https://cloud.google.com/looker/docs/db-config-google-bigquery#creating_a_temporary_dataset_for_persistent_derived_tables).

<h2><span style="color:#2d7eea"> Required User Attributes</span></h2>

Some dashboards require Looker [user attributes](https://cloud.google.com/looker/docs/admin-panel-users-user-attributes) to work properly. User attributes provide a customized experience for each Looker user. A Looker administrator defines a user attribute and then applies a user attribute value to a user group or to individual users. For more information, see [Admin settings - User attributes](https://cloud.google.com/looker/docs/admin-panel-users-user-attributes).

For this Looker Block for SAP, a Looker Administrator should create the following user attributes and set the values **exactly** as follows:


| **Required User Attribute Name** | **Label**                            | **Description** | **Default Value** |
|----------------------------------|--------------------------------------|---------------|-----------------|
| cortex_sap_default_target_currency  | Cortex SAP: Default Target Currency  | Impacts the default target currency to display in dashboards. The provided dashboards allow users to switch currencies. | **USD** or desired currency like EUR, CAD or JPY |
| cortex_default_language_key | Cortex SAP: Default SAP Language Key | Manages the language displayed for descriptions such as customer name, distribution channel names, and product name. | Enter the desired SAP language key or **E** for English if using the provided test data |
| cortex_use_test_data | Cortex SAP: Use Test Data (Yes or No) | If set to **Yes**, current date is replaced with November 20, 2023 for calculations. This ensures accurate calculations for dimensions like age of receivables. | Enter **Yes** if using Cortex Framework test data. Otherwise, enter **No**. |
| cortex_sap_show_original_sap_field_name | Cortex SAP: Show original SAP field name in label (Yes or No) | If set to **Yes**, the original SAP code like MANDT or VBELN will be shown in the field label when the constant label_sap_field_name is used. | Enter preferred value, either **Yes** or **No**. |

For all of the user attributes, configure these properties as follows:
- **Data Type**: String
- **User Access**: Edit
- **Hide Value**: No

Each dashboard user can personalize these values by following the instructions in [Personalizing user account settings](https://cloud.google.com/looker/docs/user-account).


<h2><span style="color:#2d7eea">Other Considerations</span></h2>

- **Liquid Templating Language**: Some constants, views, explores and dashboard use liquid templating language. For more information, see Looker's [Liquid Variable Reference](https://cloud.google.com/looker/docs/liquid-variable-reference) documentation.

- **(Optional) Unhide additional dimensions and measures**: Many dimensions and measures are hidden for simplicity. If you find anything valuable missing, update the field's `hidden` parameter value to **No** in the relevant views.

<h2><span style="color:#2d7eea">Additional Resources</span></h2>

To learn more about LookML and how to develop visit:
- [Looker Best Practices](https://cloud.google.com/looker/docs/best-practices/home)
- [Looker/Google Cloud Training](https://www.cloudskillsboost.google/catalog)
