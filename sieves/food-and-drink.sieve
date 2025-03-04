require ["fileinto", "imap4flags", "vnd.proton.expire"];

# Commonly used food vendors
if address :matches :domain "from" ["*meny.no", "*foodora.no", "*wolt.com"]
{
    fileinto "Mat og drikke";
    expire "day" "365";
    stop;
}