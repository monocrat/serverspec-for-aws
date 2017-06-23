# -*- coding: utf-8 -*-
require 'spec_helper'

describe command('authconfig --test | grep "retry"') do
  its(:stdout) { should match /.*retry=[1-3].*/ }
end

describe command('grep "^minlen" /etc/security/pwquality.conf') do
  its(:stdout) { should match /.*minlen\s=\s[4-9]\|\d{2,}.*/ }
  puts "bbbbbbbbbb"
end

describe '新規作成されたユーザに対して行うテスト' do
  before do
#    Specinfra.backend.run_command('su').stdout.strip
    salt = [rand(64),rand(64)].pack("C*").tr("\x00-\x3f","A-Za-z0-9./")
    pass = 'password'
    p2 = pass.crypt(salt)

    puts 'sudo test start'
#    Specinfra.backend.run_command('sudo passwd test').stdout

    puts 'sudo test end'
  end

  describe 'ユーザのパスワード有効期限を0にすると、ログイン時に再設定を求められること' do
    su_password = 'asdf1234'
    sudo_command = 'echo "' + su_password + '" | sudo -S '
    user_create_command = sudo_command + 'useradd test-user -p ""'
    password_lifetime_reset_command = sudo_command + 'chage -d 0 test-user'
    user_delete_command = sudo_command + 'userdel -r test-user'

    Specinfra.backend.run_command(user_create_command).stdout
    Specinfra.backend.run_command(password_lifetime_reset_command).stdout
    describe command('echo "" | su test-user') do
      its(:stderr) { should match /.*You are required to change your password immediately (root enforced).*/ }
    end
    Specinfra.backend.run_command(user_delete_command).stdout
  end

#  describe file('/home/Hiroki.Yokoyama/a.txt') do
#    it { should exist }


  describe command('echo "asdf1234" | sudo -S echo "hello"') do
    its(:stdout) { should match /hello/ }
  end

#  describe user('test') do
#    its(:maximum_days_between_password_change) { should eq 100 }
#  end

end
