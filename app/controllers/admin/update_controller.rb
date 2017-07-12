class Admin::UpdateController < Admin::BaseController
  def pull

    require 'net/ssh'

    host1 = "msslva-mocobp01.csc.nycnet"
    host2 = "msslva-mocobp02.csc.nycnet"
    username = "openbid"
    command = "update"

    Net::SSH.start(host1, username, :keys => ['/export/local/openbid/.ssh/id_rsa']) do |ssh|
      ssh.exec!("cd /opt/rh/nginx16/root/usr/share/nginx/openbid/ && git pull")
    end

    Net::SSH.start(host2, username, :keys => ['/export/local/openbid/.ssh/id_rsa']) do |ssh|
      ssh.exec!("cd /opt/rh/nginx16/root/usr/share/nginx/openbid/ && git pull")
    end

    flash[:notice] = "Stage server(s) successfully updated from GITHUB repo"
  end
end
