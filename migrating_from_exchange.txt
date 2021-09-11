**Source: (https://web.archive.org/web/20201027040701/https://help.bittitan.com/hc/en-us/articles/115008258628-How-do-I-disable-the-throttling-policy-on-Exchange-)**

Exchange Server has very low throttling policy limits. We recommend disabling the throttling limits during the migration.

Notes:

This is only relevant if throttling policies are enabled in the Exchange environment.
Exchange Server 2007 does not have configuration options for throttling policies, as future versions do. For Exchange 2007's version of ​Client Throttling, see Understanding Client Throttling.
Exchange 2003 does not have any throttling policies, or any client throttling.
When migrating to Office 365, you cannot disable throttling on Office 365.
If you are creating or applying a throttling policy on Exchange, you will need to use delegation for this endpoint.
Option 1: Disable throttling against only the migrating account (if not using impersonation). This way, the admin account can migrate at a faster rate because it is not subjected to any throttling.

Notes:

Use this option if not using impersonation during the migration, but instead using delegation.
If migrating using admin credentials, it is only necessary to disable throttling against the admin account, rather than all users.
If migrating mailboxes using administrative credentials at the Source, but not using impersonation, we recommend disabling throttling limits on this administrative account in order to improve the speed of migration.
We recommend the creation of a migration administrative account and disabling policy enforcement for this account.
Disable Admin throttling in Exchange Server 2010:

To disable all throttling parameters for an admin account called "MigrationWiz":

On a computer that hosts the Microsoft Exchange Management Shell, open the Microsoft Exchange Management Shell.
Type the following command and press Enter.
New-ThrottlingPolicy MigrationWizPolicy
Type the following command and press Enter.
Set-ThrottlingPolicy MigrationWizPolicy -RCAMaxConcurrency $null -RCAPercentTimeInAD $null -RCAPercentTimeInCAS $null -RCAPercentTimeInMailboxRPC $null -EWSMaxConcurrency $null -EWSPercentTimeInAD $null -EWSPercentTimeInCAS $null -EWSPercentTimeInMailboxRPC $null -EWSMaxSubscriptions $null -EWSFastSearchTimeoutInSeconds $null -EWSFindCountLimit $null -CPAMaxConcurrency $null -CPAPercentTimeInCAS $null -CPAPercentTimeInMailboxRPC $null -CPUStartPercent $null
Type the following command and press Enter.
Set-Mailbox "MigrationWiz" -ThrottlingPolicy MigrationWizPolicy
Exchange Server 2013 or 2016:

To disable all throttling parameters for an admin account called "MigrationWiz":

Open the Exchange Management Shell.
Type the following command and press Enter.
New-ThrottlingPolicy MigrationWizPolicy

Type the following command and press Enter.
Set-ThrottlingPolicy MigrationWizPolicy -RCAMaxConcurrency Unlimited -EWSMaxConcurrency Unlimited -EWSMaxSubscriptions Unlimited -CPAMaxConcurrency Unlimited -EwsCutoffBalance Unlimited -EwsMaxBurst Unlimited -EwsRechargeRate Unlimited

Type the following command and press Enter.
Set-Mailbox "MigrationWiz" -ThrottlingPolicy MigrationWizPolicy

Option 2: Disable throttling against all user accounts (if migrating using an admin account and using impersonation). This way the admin account can migrate at a faster rate because it impersonates user accounts, which are not subjected to throttling.

Notes:

If migrating mailboxes using administrative credentials at the Source, and using impersonation, disabling throttling limits on all mailboxes will improve the speed of migration, but it is a security risk. The throttling limits are working together to protect an Exchange server from being overwhelmed by accepting and delivering messages.
Read Understanding message rate limits and throttling before you execute the scripts below.
Exchange Server 2010:

To disable all throttling parameters for all mailboxes:

On a computer that hosts the Microsoft Exchange Management Shell, open the Microsoft Exchange Management Shell.
Type the following command and press Enter.
New-ThrottlingPolicy MigrationWizPolicy
Type the following command and press Enter. 
Set-ThrottlingPolicy MigrationWizPolicy -RCAMaxConcurrency $null -RCAPercentTimeInAD $null -RCAPercentTimeInCAS $null -RCAPercentTimeInMailboxRPC $null -EWSMaxConcurrency $null -EWSPercentTimeInAD $null -EWSPercentTimeInCAS $null -EWSPercentTimeInMailboxRPC $null -EWSMaxSubscriptions $null -EWSFastSearchTimeoutInSeconds $null -EWSFindCountLimit $null -CPAMaxConcurrency $null -CPAPercentTimeInCAS $null -CPAPercentTimeInMailboxRPC $null -CPUStartPercent $null
Type the following command and press Enter.
Get-Mailbox | Set-Mailbox -ThrottlingPolicy MigrationWizPolicy
Note: The steps above will remove throttling policies against all user accounts at your Source. You still need to enable impersonation within your MigrationWiz project, so that the admin account can impersonate the user accounts during migrations, and so that the migrations use the bandwidth available to the individual user accounts, rather than just the bandwidth available to the admin account. Follow the directions in the Help Center article How do I migrate to Exchange or Office 365 using impersonation? to enable this.

Exchange Server 2013 or 2016:

To disable all throttling parameters for all mailboxes:

Open the Exchange Management Shell.
Type the following command and press Enter.
New-ThrottlingPolicy MigrationWizPolicy

Type the following command and press Enter.
Set-ThrottlingPolicy MigrationWizPolicy -RCAMaxConcurrency Unlimited -EWSMaxConcurrency Unlimited -EWSMaxSubscriptions Unlimited -CPAMaxConcurrency Unlimited -EwsCutoffBalance Unlimited -EwsMaxBurst Unlimited -EwsRechargeRate Unlimited

Enter the following command and press Enter. 
Get-Mailbox | Set-Mailbox -ThrottlingPolicy MigrationWizPolicy

Note: The steps above will remove throttling policies against all user accounts at your Source. You still need to enable impersonation within your MigrationWiz project, so that the admin account can impersonate the user accounts during migrations, and so that the migrations use the bandwidth available to the individual user accounts, rather than just the bandwidth available to the admin account. Follow the directions in the Help Center article How do I migrate to Exchange or Office 365 using impersonation? to enable this.
