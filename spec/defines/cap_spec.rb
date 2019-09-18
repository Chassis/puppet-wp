require 'spec_helper'

describe 'Wp::Cap' do
	let(:environment) { 'development' }
	let(:title) { 'wp cap' }
	let(:params) do {
		'role'     => 'editor',
		'cap'      => 'edit_posts',
		'location' => '/vagrant',
	}
	end
	it { is_expected.to compile }

	# Test a cap removal.
	context 'cap removal' do
		let(:params) do
		  super().merge({ 'ensure' => 'absent' })
		end
		it { is_expected.to compile }
	end

	# Test a custom location.
	context 'with location => /chassis' do
		let(:params) do
		  super().merge({ 'location' => '/chassis' })
		end
		it { is_expected.to compile }
	end

	# Test without role.
	context 'without role' do
		let(:params) do
		  super().merge({ 'role' => '' })
		end
		it { is_expected.to compile }
	end

	# Test without cap.
	context 'without cap' do
		let(:params) do
		  super().merge({ 'cap' => '' })
		end
		it { is_expected.to compile }
	end

	# Test without ensure.
	context 'without ensure' do
		let(:params) do
		  super().merge({ 'ensure' => '' })
		end
		it { is_expected.not_to compile }
	end

	# Test with grant false.
	context 'grant false' do
		let(:params) do
		  super().merge({ 'grant' => false })
		end
		it { is_expected.to compile }
	end

	# Test with a different user.
	context 'cap with different user' do
		let(:params) do
		  super().merge({ 'user' => 'vagrant' })
		end
		it { is_expected.to compile }
	end

	# Test without onlyif.
	context 'without onlyif' do
		let(:params) do
		  super().merge({ 'onlyif' => '' })
		end
		it { is_expected.not_to compile }
	end
end
