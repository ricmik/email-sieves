require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest", "fileinto", "imap4flags", "vnd.proton.expire"];

# Generated: Do not run this script on spam messages
if allof (environment :matches "vnd.proton.spam-threshold" "*",
spamtest :value "ge" :comparator "i;ascii-numeric" "${1}")
{
    return;
}

# Commonly used social networks
if address :matches :domain "from" ["*linkedin.com", "*facebookmail.com", "*facebook.com", "*reddit.com", "*twitter.com", "*instagram.com", "*pinterest.com", "*meetup.com", "*tumblr.com", "*ycombinator.com"]
{
    fileinto "Oppdateringer";
    expire "day" "90";
    stop;
}

# Commonly used tech services
# Security has it's own folder - don't put tech security services here.
if address :matches :domain "from" ["*digitalocean.com", "*github.com", 
"*cloudflare.com", "*docker.com", "*heroku.com", "*keybase.io", "*adobe.com", 
"*netflix.com", "*google.com", "*youtube.com", "*apple.com", "*roku.com", 
"*namecheap.com", "*microsoft.com", "*ebay.com", "*spotify.com", "*plex.tv", "*logitech.com"]
{
    fileinto "Oppdateringer";
    expire "day" "365";
    stop;
}
