require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest", "fileinto", "imap4flags", "vnd.proton.expire"];

# Generated: Do not run this script on spam messages
if allof (environment :matches "vnd.proton.spam-threshold" "*",
spamtest :value "ge" :comparator "i;ascii-numeric" "${1}")
{
    return;
}

# Smartdelay updates
if address :matches :domain "from" ["*smartdelay.com"]
{
    fileinto "Billetter og reservasjoner";
    expire "day" "30";
    stop; 
}

# Commonly used travel services
if address :matches :domain "from" ["*norwegian.com", "*norwegian.no", "flysas.com", "*airbnb.com", 
"*uber.com", "*hertz.com", "*avis.com", "*hotels.com", 
"*tripadvisor.com", "connectbus.no"]
{
    fileinto "Billetter og reservasjoner";
    expire "day" "730";
    stop; 
}