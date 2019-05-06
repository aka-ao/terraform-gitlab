variable "aws_access_key" {
  description = "AWS APIアクセスキー"
}

variable "aws_secret_key" {
  description = "AWS APIシークレットキー"
}

variable "ssh_private_key_path" {
  description = "秘密鍵ファイルのPath"
}

variable "ssh_public_key_path" {
  description = "公開鍵ファイルのPath"
}

variable "prefix" {
  description = "リソースの名前のPrefix"
  default     = "DevEnv"
}

variable "instance_type" {
  description = "インスタンスタイプ"
  default     = "t2.large"
}

variable "volume_size" {
  description = "ボリュームサイズ [GB]"
  default     = "20"
}

variable "region" {
  description = "リージョン"

  # デフォルト：アジアパシフィック (東京)
  default = "ap-northeast-1"
}

variable "subnet_id" {
  description = "既存サブネットのid"
}

variable "private_ip" {
  description = "作成するインスタンスの private IP（intraのDNSサーバ/サービスに登録した/するIP）"
}

variable "security_group_id" {
  description = "既存セキュリティグループのid"
}

variable "ami" {
  description = "Amazon マシンイメージ（AMI）"

  # デフォルト：Amazon Linux (HVM（SSD）EBS-Backed 64 ビット) @ Tokyo
  default = "ami-0f9ae750e8274075b"
}

variable "ssh_user_name" {
  description = "デフォルトユーザー"

  # デフォルト：Amazon Linux
  default = "ec2-user"
}

variable "ldap_organisation" {
  description = "LDAPを利用する組織"
}

variable "ldap_domain" {
  description = "LDAPを利用するドメイン"
}

variable "ldap_admin_password" {
  description = "LDAPのadminユーザーパスワード"
}
