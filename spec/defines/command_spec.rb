require 'spec_helper'

describe 'Wp::Command' do
	let(:environment) { 'development' }
	let(:title) { 'wp --info' }
	let(:params) do {
			'location' => '/vagrant',
			'command'  => '--info',
			'user'     => 'www-data',
			'unless'   => :undef,
			'onlyif'   => "/vagrant/wp is-installed",
			'require'  => ref( 'Class', 'wp::cli'),
	}
	end
	it { is_expected.to compile }
end
