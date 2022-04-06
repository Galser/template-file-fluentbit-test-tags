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


