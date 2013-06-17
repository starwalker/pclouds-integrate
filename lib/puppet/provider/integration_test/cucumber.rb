require 'facter'
require 'pp'

$debug=true

Puppet::Type.type(:integration_test).provide(:cucumber) do
	desc "Implement cucumber based integration testing.."

	# Only allow the provider if cucumber is installed.
	commands :cucumber => 'cucumber'

	mk_resource_methods

	#def aws_access_key_id=(value)
	#	@updated_properties = true
	#	@property_hash[:aws_access_key_id] = value
	#end

	#def aws_secret_access_key=(value)
	#	@updated_properties = true
	#	@property_hash[:aws_secret_access_key] = value
	#end

	#def regions=(value)
	#	@updated_properties = true
	#	@property_hash[:regions] = value
	#end

	def create
	end

	def destroy
	end

	def exists?
	end
end
