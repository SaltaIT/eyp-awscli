require 'spec_helper_acceptance'
require_relative './version.rb'

describe 'awscli class' do

  context 'basic setup' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOF

      class { 'awscli': }

      awscli::profile { 'default':
        aws_access_key_id => 'a',
        aws_secret_access_key => 'b',
      }

      awscli::profile { 'test':
        aws_access_key_id => '1',
        aws_secret_access_key => '2',
      }

      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    describe file("/root/.aws/config") do
      it { should be_file }
      its(:content) { should match '# puppet managed file' }
    end

  end
end
