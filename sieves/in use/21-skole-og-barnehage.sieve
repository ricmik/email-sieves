require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest", "fileinto", "imap4flags", "vnd.proton.expire"];

# Generated: Do not run this script on spam messages
if allof (environment :matches "vnd.proton.spam-threshold" "*", spamtest :value "ge" :comparator "i;ascii-numeric" "${1}") {
    return;
}

# Filter for from:donotreply@info.kidplan.com
if address :contains "From" "donotreply@info.kidplan.com" {
    # This is purely extra protection in the event the sieves don't work as expected
    if hasexpiration
    {
        unexpire;
    }    
    fileinto "Barnehagen";
    stop;
}

if address :matches :domain "from" ["*kardemomme.no"]
{
    # This is purely extra protection in the event the sieves don't work as expected
    if hasexpiration
    {
        unexpire;
    }   
    fileinto "Barnehagen";
    stop;
}
