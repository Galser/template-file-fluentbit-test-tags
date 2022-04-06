# template-file-fluentbit-test-tags
Fluent-bit testing of TAG and UUID in TF template

# Code to test Fluent bit config interpolation

Givem the code  in [main.tf](main.tf) :

```Terraform
data "template_file" "fluent" {
  template = "${file("${path.module}/fluent.tftpl")}"
  vars = {
    dcio = "TESTDC1"
    application_name = "asterix"
    environment = "dev"
  }
}

output "fluent-config-quote" {
  value = data.template_file.fluent.rendered
}
```

And templarte file in [fluent.tftpl](fluent.tftpl) as following :

```
"log_forwarding_enabled": {
"value": "1"
},
"log_forwarding_config": {
"value":"\n[OUTPUT]\n Name s3\n Match *\n bucket ${dcio}-${application_name}-int-${environment}-server-data\n region us-east-1\n total_file_size 10M\n s3_key_format /$TAG/%Y/%m/%d/%H/%M/%S/$UUID.gz"
},
```


We have such example of one `apply`

```Terraform
 terraform apply --auto-approve

Changes to Outputs:
  + fluent-config-quote = <<-EOT
        "log_forwarding_enabled": {
        "value": "1"
        },
        "log_forwarding_config": {
        "value":"\n[OUTPUT]\n Name s3\n Match *\n bucket TESTDC1-asterix-int-dev-server-data\n region us-east-1\n total_file_size 10M\n s3_key_format /$TAG/%Y/%m/%d/%H/%M/%S/$UUID.gz"
        },

    EOT

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

fluent-config-quote = <<EOT
"log_forwarding_enabled": {
"value": "1"
},
"log_forwarding_config": {
"value":"\n[OUTPUT]\n Name s3\n Match *\n bucket TESTDC1-asterix-int-dev-server-data\n region us-east-1\n total_file_size 10M\n s3_key_format /$TAG/%Y/%m/%d/%H/%M/%S/$UUID.gz"
},


EOT
```

