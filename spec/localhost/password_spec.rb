# -*- coding: utf-8 -*-
require 'spec_helper'

describe command('authconfig --test | grep "retry"') do
  its(:stdout) { should match /.*retry=[1-3].*/ }
end

describe command('grep "^minlen" /etc/security/pwquality.conf') do
  its(:stdout) { should match /.*minlen\s=\s[4-9]\|\d{2,}.*/ }
  puts "bbbbbbbbbb"
end
