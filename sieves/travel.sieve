require ["fileinto", "imap4flags", "vnd.proton.expire"];

# Smartdelay updates
if address :matches :domain "from" ["*smartdelay.com"]
{
    fileinto "Reise";
    expire "day" "30";
    stop; 
}

# Commonly used travel services
if address :matches :domain "from" ["*norwegian.com", "*norwegian.no", "flysas.com", "*airbnb.com", 
"*uber.com", "*hertz.com", "*avis.com", "*hotels.com", 
"*tripadvisor.com", "connectbus.no"]
{
    fileinto "Reise";
    expire "day" "730";
    stop; 
}