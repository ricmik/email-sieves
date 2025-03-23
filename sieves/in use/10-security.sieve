require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest", "fileinto", "imap4flags", "vnd.proton.expire"];

# Generated: Do not run this script on spam messages
if allof (environment :matches "vnd.proton.spam-threshold" "*",
spamtest :value "ge" :comparator "i;ascii-numeric" "${1}")
{
    return;
}

# This sieve is high up in the execution chain, as we want to short-circuit these from other sieves and centralize all security events.

# Common subjects relevant to security events
if header :contains "subject" ["security alert", "security notification", "login", "sign-on", 
"sign-in", "sign in", "sign on", "email address", "email change", "password", "terms of service",
"reset", "recovery key", "verify", "verification", "email removed", "new device", "email removal",
"access code", "privacy request", "terms and conditions", "sikkerhetsvarsel", "pålogging"] 
{
    fileinto "Sikkerhet";
    expire "day" "180";
    stop;
}

# Commonly used security services
elsif address :matches :domain "from" ["*lastpass.com", "*logme.in", "*okta.com", "*accounts.google.com", 
"*1password.com", "*haveibeenpwned.com", "*nextdns.io"]
{
    fileinto "Sikkerhet"; 
    expire "day" "180";
    stop;
}