require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest", "fileinto", "imap4flags", "vnd.proton.expire"];

# Generated: Do not run this script on spam messages
if allof (environment :matches "vnd.proton.spam-threshold" "*", spamtest :value "ge" :comparator "i;ascii-numeric" "${1}") {
    return;
}

# Filter for from:no-reply@firi.com
if address :contains "From" "no-reply@firi.com" {
    if header :contains "Subject" "Kryptosparing gjennomført" {
        setflag "\\Seen";
        expire "day" "10";
        fileinto "Finans/Firi";
        stop;
    }
    fileinto "Finans/Firi";
    stop;
}

# Filter for Binance Recurring Buy Deduction Reminder
if allof (address :contains "From" "binance.com", header :contains "Subject" "Recurring Buy Deduction Reminder") {
    addflag "\\Seen";
    fileinto "Trash";
    stop;
}

# Filter for specific Binance success emails
if allof (address :contains "From" "binance.com", 
          anyof (header :contains "Subject" "Recurring buy success",
                header :contains "Subject" "Buy with card successful")) {
    fileinto "Finans/Binance";
    addflag "\\Seen";
    stop;
}

# Filter for from:noreply@nordnet.no
if address :contains "From" "noreply@nordnet.no" {
    fileinto "Finans/Nordnet";
    stop;
}

