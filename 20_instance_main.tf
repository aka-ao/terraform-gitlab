resource "aws_instance" "main" {
  subnet_id  = "${var.subnet_id}"
  private_ip = "${var.private_ip}"

  vpc_security_group_ids = [
    "${var.security_group_id}",
  ]

  disable_api_termination = true

  instance_type = "${var.instance_type}"
  ami           = "${var.ami}"

  root_block_device {
    volume_size = "${var.volume_size}"
  }

  key_name = "${aws_key_pair.deployer.key_name}"

  tags {
    Name = "${var.prefix}-main"
  }

  connection {
    user        = "${var.ssh_user_name}"
    private_key = "${file(var.ssh_private_key_path)}"
  }

  # Wait for cloud-init to finish
  provisioner "remote-exec" {
    inline = [
      "while ! grep 'Cloud-init .* finished' /var/log/cloud-init.log; do echo 'Waiting for cloud-init to finish'; sleep 2; done",

      # ↓がないと後でyum installが失敗した
      "echo 'Waiting for 30 seconds...'; sleep 30",
    ]
  }

  lifecycle {
    ignore_changes = [
      "tag",
    ]
  }
}

output "LDAP: Administration Login DN" {
  value = "cn=admin,${join(",", formatlist("dc=%v", split(".", var.ldap_domain)))}"
}

resource "null_resource" "setup_gitlab" {

  connection {
    host        = "13.231.137.209"
    user        = "${var.ssh_user_name}"
    private_key = "${file("${var.ssh_private_key_path}")}"
  }

  provisioner "remote-exec" {
    inline = [
      "curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash",
      "sudo yum -y install gitlab-ce",
    ]
  }
}