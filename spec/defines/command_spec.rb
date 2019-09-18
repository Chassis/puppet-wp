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

	# Test a custom location.
	context 'with location => /chassis' do
		let(:params) do
		  super().merge({ 'location' => '/chassis' })
		end
		it { is_expected.to compile }
	end

	# Test a custom user.
	context 'with user => /vagrant' do
		let(:params) do
		  super().merge({ 'user' => 'vagrant' })
		end
		it { is_expected.to compile }
	end

	# Test a without location.
	context 'without location' do
		let(:params) do
		  super().merge({ 'location' => '' })
		end
		it { is_expected.not_to compile }
	end

	# Test a without command.
	context 'without command' do
		let(:params) do
		  super().merge({ 'command' => '' })
		end
		it { is_expected.to compile }
	end

	# Test a without user.
	context 'without user' do
		let(:params) do
		  super().merge({ 'user' => '' })
		end
		it { is_expected.to compile }
	end

	# Test a without onlyif.
	context 'without onlyif' do
		let(:params) do
		  super().merge({ 'onlyif' => '' })
		end
		it { is_expected.not_to compile }
	end
end
