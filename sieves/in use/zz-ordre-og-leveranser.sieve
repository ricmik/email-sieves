require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest", "fileinto", "imap4flags", "vnd.proton.expire"];

# Generated: Do not run this script on spam messages
if allof (environment :matches "vnd.proton.spam-threshold" "*",
spamtest :value "ge" :comparator "i;ascii-numeric" "${1}")
{
    return;
}

# General catch all for delivery events. 
# Delete after 180 days, as this info can almost always be retrieved from the source of truth
# Sieve ordering is important here, as you can receive an email that contains "order delivered" in the subject (which would conflict with the "order handling" sieve that follows).
if header :contains "subject" ["shipping", "shipped", "delivered", "delivery", "levert", "leveringsbekreftelse", "leveranse"]
{
    # folder
    fileinto "Paper Trail";
    # label
    fileinto "Leveranse"; 
    expire "day" "180";
    stop;
}

# General catch all for invoices and recepts.
# Do not expire, as these emails might be historically significant.
if header :contains "subject" ["invoice", "receipt", "kvittering", "faktura"]
{
    if header :contains "X-Business-Group" "iTunes" {
        fileinto "Paper Trail";
        fileinto "Kvittering";
        expire "day" "30";  # Kun for iTunes
    } else {
        if hasexpiration {
            unexpire;
        }
        fileinto "Paper Trail";
        fileinto "Kvittering";
    }
    stop;
}

# General catch all for orders.
# Do not expire, as these emails might be historically significant.
if header :contains "subject" ["order", "ordrebekreftelse", "bestillingsoversikt", "bestillingsbekreftelse"]
{
    # This is purely extra protection in the event the sieves don't work as expected
    if hasexpiration
    {
        unexpire;
    }
    # folder
    fileinto "Paper Trail";
    # label
    fileinto "Ordrebekreftelse";
    stop;
}

# More targeted for catching general communication and updates. 
# Delete after 30 days, as this info can almost always be retrieved from the source of truth.
elsif address :matches :domain "from" ["*postnord.no", "*posten.no", "*helthjem.no", "*ups.com", "*upsemail.com", "*usps.com", "*fedex.com", "*etsy.com", "*amazon.com"]
{
    # folder
    fileinto "Paper Trail"; 
    # label
    fileinto "Leveranse";
    expire "day" "30";
}