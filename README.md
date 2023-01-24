### Create Parallel/multi resources in multiple account using terraform

### We use Terragrunt to manage multiple terraform modules 
## Terragrunt is a thin wrapper that provides extra tools for keeping your configurations DRY, working with multiple Terraform modules, and managing remote state.  https://terragrunt.gruntwork.io/

### How to ###

## 1) Terraform Directory structure follows the AWS Oraganization (Multi Accout Strategy), so the management and automation will be easy via terraform

# for example, assume the accouts are created as below

Organization (root/master)

├───core (OU)


│   ├───Automation (OU) #hold creds for automation terraform/jenkin

│   │   ├───nonprod-automation  (NONPROD automation account)

│   │   ├───prod-automation (PROD automation account)

├───workload (OU)

│   ├───productions (OU) # containts production accounts

│   │   ├───prod1  # (PROD production accounts1)

│   │   ├───prod2  #(PROD production accounts2)

│   ├───uat (OU) # containts UAT accounts

│   │   ├───uat1  

│   │   ├───uat2

│   |---Sandbox (OU) # containts Sandbox accounts

│   │   ├───sbx1

│   │   ├───sbx2

│   |---logging(OU) # containts Sandbox accounts

│   │   ├───prod-log  # prod logging account

│   │   ├───nprod-log # non-prod logging account

## 2) Output of Directory struct following the above Org structure


clone this repo

cd terraform-ParallelResource-deploy
$ tree .

├───core

│   └───Automation

│       ├───nonprod-automation

│       └───prod-automation

├───logging

│   ├───nprod-log

│   └───prod-log

└───workload

    ├───productions

    │   ├───prod1

    │   └───prod2

    ├───Sandbox

    │   ├───sbx1

    │   └───sbx2

    └───uat

        ├───.terragrunt-cache

        ├───uat1

        └───uat2




## 3) create/update account.hcl with your account name and number. I create the dictotry name similar to account name to simply/manage efficiently the terraform modules to distinguish

# maintaing the directory structure with AWs Org Struction will give us space for a lot of automation to generate dynamic approtiate resorources. It will be explained below

cat accounts.hcl

inputs = {

    nonprod-automation = "012345678901"

    prod-automation = "012345678901"

    prod1 = "012345678901"

    prod2 = "012345678901"

    uat1 = "012345678901"

    uat2 = "012345678901"

    sbx1 = "012345678901"

    sbx2 = "012345678901"

    prod-log = "012345678901"

    nprod-log = "012345678901"

}


## 4) Refer the parallel_deployment. Created "env.json" to distinguish the environment. So the resoruce can be created specific to the environment. Under 

{

    "nonprod-automation" :"nonprod",

    "uat1" :"nonprod",

    "uat2" :"nonprod",

    "sbx1" :"nonprod",

    "sbx2" :"nonprod",

    "nprod-log": "nonprod",

    "prod-automation" :"prod",

    "prod1" :"prod",

    "prod2" :"prod",

    "prod-log": "prod"

}

## 5) If you want to create resources in all account, place your tf file under parallel_deployment/all_accounts. If for prod accounts only, place your file under parallel_deployment/prod and for nonprod accounts only parallel_deployment/nonprod. 
## In this excersize lets create the iam resource on all account 

cd parallel_deployment/all_accounts

NagarajansMBP2:all_accounts $ ls

all_iam_base.tf         outputs_base.tf         variables_base.tf


## 5) Run "terragrunt run-all plan" to copy/overwrite files from parallel_deployment/all_accounts to all accounts folder

from parallel_deployment/all_accounts

to
core/Automation/nonprod-automation, prod-automation
wordload/porudtions/prod1 prod2
wordload/uat/uat1 uat2
wordload/sandbox/sbx1 sbx2
wordload/logging/prod-log, nprod-log

## under the hood ##
terragrunt looks for "terragrunt.hcl" file in all the directory resursively and load the file.

one of the directive in terragrunt.hcl is

include "common" {
  path = find_in_parent_folders("resource_deployment.hcl")

}

terragrunt executes the file in "Organization/resource_deployment.hcl" i which executes "parallel_deployment/main.sh" with every directory as an argument 

The scrips then copy the file from central location parallel_deployment/all_accounts to all accounts directory

NagarajansMBP2:nonprod-automation mahaakutty$ ls -l *base*

-rw-r--r--  1 NagarajansMBP2  staff  634 14 Jul  2022 all_iam_base.tf

-rw-r--r--  1 NagarajansMBP2  staff  121 14 Jul  2022 outputs_base.tf

-rw-r--r--  1 NagarajansMBP2  staff  217 14 Jul  2022 variables_base.tf

NagarajansMBP2:nonprod-automation NagarajansMBP2$ pwd
/Users/NagarajansMBP2/repos/terraform-ParallelResoruce-deploy/Organization/core/Automation/nonprod-automation
NagarajansMBP2:nonprod-automation NagarajansMBP2$


## Terragrunt run-all apply will create the resource then

## if you want perform individual resource creation, go the account directory and run terragrunt init/plan/apply/destrouy 

NagarajansMBP2:terraform-ParallelResoruce-deploy mahaakutty$ cd Organization/core/Automation/nonprod-automation
NagarajansMBP2:nonprod-automation mahaakutty$ terragrunt plan

This  will load the terragrunt.hcl file in the local directory and get the file from central location and create it

You can create addional local file if you want such creating bucket s3.tf on this account. 


## DEMO ###

1) $ clone this repo

2)
$cd terraform-ParallelResource-deploy

$ls
core  logging  ou_dep.hcl  parallel.hcl  providers.hcl  providers_acc.hcl  README.md  resource_deployment.hcl  state.hcl  tf.hcl  workload


3) 
$ find . -name *base.tf

$

C:/Users/nagarajan/repos/multi/Organization/core/Automation/nonprod-automation nonprod-automation ../../../../parallel_deployment
/c/Users/nagarajan/repos/multi/Organization/core/Automation/nonprod-automation

coping files from ../../../../parallel_deployment/all_accounts to C:/Users/nagarajan/repos/multi/Organization/core/Automation/nonprod-automation
Copy environment spec files

C:/Users/nagarajan/repos/multi/Organization/core/Automation/prod-automation prod-automation ../../../../parallel_deployment
/c/Users/nagarajan/repos/multi/Organization/core/Automation/prod-automation
coping files from ../../../../parallel_deployment/all_accounts to C:/Users/nagarajan/repos/multi/Organization/core/Automation/prod-automation
Copy environment spec files

C:/Users/nagarajan/repos/multi/Organization/logging/nprod-log nprod-log ../../../parallel_deployment
/c/Users/nagarajan/repos/multi/Organization/logging/nprod-log
coping files from ../../../parallel_deployment/all_accounts to C:/Users/nagarajan/repos/multi/Organization/logging/nprod-log
Copy environment spec files

C:/Users/nagarajan/repos/multi/Organization/logging/prod-log prod-log ../../../parallel_deployment
/c/Users/nagarajan/repos/multi/Organization/logging/prod-log
coping files from ../../../parallel_deployment/all_accounts to C:/Users/nagarajan/repos/multi/Organization/logging/prod-log
Copy environment spec files

C:/Users/nagarajan/repos/multi/Organization/workload/Sandbox/sbx1 sbx1 ../../../../parallel_deployment
/c/Users/nagarajan/repos/multi/Organization/workload/Sandbox/sbx1
coping files from ../../../../parallel_deployment/all_accounts to C:/Users/nagarajan/repos/multi/Organization/workload/Sandbox/sbx1
Copy environment spec files

C:/Users/nagarajan/repos/multi/Organization/workload/Sandbox/sbx2 sbx2 ../../../../parallel_deployment
/c/Users/nagarajan/repos/multi/Organization/workload/Sandbox/sbx2
coping files from ../../../../parallel_deployment/all_accounts to C:/Users/nagarajan/repos/multi/Organization/workload/Sandbox/sbx2
Copy environment spec files

C:/Users/nagarajan/repos/multi/Organization/workload/productions/prod1 prod1 ../../../../parallel_deployment
/c/Users/nagarajan/repos/multi/Organization/workload/productions/prod1
coping files from ../../../../parallel_deployment/all_accounts to C:/Users/nagarajan/repos/multi/Organization/workload/productions/prod1
Copy environment spec files

...

....

$

4

$ find . -name *base.tf

./core/Automation/nonprod-automation/all_iam_base.tf

./core/Automation/nonprod-automation/outputs_base.tf

./core/Automation/nonprod-automation/variables_base.tf

./core/Automation/prod-automation/all_iam_base.tf

./core/Automation/prod-automation/outputs_base.tf

./core/Automation/prod-automation/variables_base.tf

./logging/nprod-log/all_iam_base.tf

./logging/nprod-log/outputs_base.tf

./logging/nprod-log/variables_base.tf

./logging/prod-log/all_iam_base.tf

./logging/prod-log/outputs_base.tf

....

....

5) terragrunt run-all apply --> to create the resource

---------- END --------------
