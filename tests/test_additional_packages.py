def test_apk_package_mysql_client(host):
  mysql_client = host.package("mysql-client")
  assert mysql_client.is_installed

def test_asdf_plugin_kubectl(host):
  kubectl = host.file("/root/.asdf/shims/kubectl")
  assert kubectl.exists
  assert kubectl.is_executable
  assert host.run_test("kubectl version --client")

def test_asdf_plugin_terraform(host):
  terraform = host.file("/root/.asdf/shims/terraform")
  assert terraform.exists
  assert terraform.is_executable
  assert host.run_test("terraform version")
