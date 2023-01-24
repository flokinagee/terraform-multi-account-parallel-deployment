
resource  "aws_lambda_invocation" "example" {
  function_name = var.packer_back_ami_function
  triggers = {
        redeployment = "${timestamp()}"
  }
  input = <<JSON
{
  "packer_template_file": "templates/packer_template.json",
  "packer_binary": "bin/packer",
  "shared_accounts": [
    "201998764740"
  ],
  "package": "package/packer.zip",
  "packer_vars": {
  "build" : "100",
  "app": "nagaapp"
  }
}
JSON
}