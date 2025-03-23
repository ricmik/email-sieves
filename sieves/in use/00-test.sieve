require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest", "fileinto", "imap4flags", "extlists", "vnd.proton.expire"];

# Generated: Do not run this script on spam messages
if allof (environment :matches "vnd.proton.spam-threshold" "*",
spamtest :value "ge" :comparator "i;ascii-numeric" "${1}")
{
    return;
}

# This sieve is useful for testing. 
# Create a contact group and name it "Meg". 
# Add your personal e-mail addresses to this group.
# You can alternatively use ":addrbook:myself" 
# but I prefer to test with external addresses.
if header :list "from" ":addrbook:personal?label=Meg"   
{    
    # do things
}