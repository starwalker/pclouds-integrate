#require 'rubygems'
#require 'facter'
#require 'yaml'
require 'pp'

Puppet::Type.newtype(:integration) do
	@doc = "Integration Test"

	ensurable

	# --------------------------------------------------------------------------------------------------------------
	# Parameters  

	newparam(:name) do
		desc "The resource name/identifier of the integration_test resource"
		isnamevar
		isrequired
	end

	#newparam(:instance_initiated_shutdown_behavior) do
	#	desc "Whether the instance stops or terminates on instance-initiated shutdown."
	#	newvalues(:stop, :terminate)
	#	defaultto :stop
	#end

	# --------------------------------------------------------------------------------------------------------------
	# Properties  

	#newproperty(:availability_zone) do
	#	desc "The availability zone that the instance should run in"
	#	newvalues(/^eu-west-\d[a-z]$/, /^us-east-\d[a-z]$/, /^us-west-\d[a-z]$/, /^ap-southeast-\d[a-z]$/, /^ap-northeast-\d[a-z]$/, /^sa-east-\d[a-z]$/) 
	#end


	# --------------------------------------------------------------------------------------------------------------
	# Validation and autorequires... 

	#validate do
	#	# Validate that the :availability_zone and :region are correct if both specified.
	#	if (self[:region] && self[:availability_zone]) 
	#		if (self[:region] != self[:availability_zone].gsub(/.$/,''))
	#			raise ArgumentError , "ec2instance: Sorry, availability_zone #{self[:availability_zone]} is in region #{self[:availability_zone].gsub(/.$/,'')}.  Please leave the 'region' blank or correct it."
	#		end
	#	end
	#end

	# Special autorequire for all objects in the catalog except for other integration tests!
	# I have had to implement this by overiding the type autorequire method which is concered with building up
	# predefined hashes of types to autorequire and replace with a simpler function which will try to autorequire 
	# EVERYTHING in the catalog.. except some of the built in component types and our Integration type.

	def autorequire(rel_catalog = nil)

		rel_catalog ||= catalog
		raise(Puppet::DevError, "You cannot add relationships without a catalog") unless rel_catalog

		# Do not autorequire these types!
		ignore_types = [ "Puppet::Type::Stage", "Puppet::Type::Component", "Puppet::Type::Integration", "Puppet::Type::Schedule", "Puppet::Type::Filebucket" ]
		reqs = []
		catalog.resources.each {|d|
			reqs << Puppet::Relationship.new(d, self) if (!ignore_types.include?(d.class.to_s))
		}
		reqs
	end

end

