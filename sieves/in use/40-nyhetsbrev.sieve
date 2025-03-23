require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest", "fileinto", "imap4flags", "vnd.proton.expire"];

# Generated: Do not run this script on spam messages
if allof (environment :matches "vnd.proton.spam-threshold" "*",
spamtest :value "ge" :comparator "i;ascii-numeric" "${1}")
{
    return;
}

# Generic filter for Mailchimp lists (*.list-id.mcsv.net)
if header :contains "List-Id" ".list-id.mcsv.net" {
	fileinto "Nyhetsbrev";
	expire "day" "180";
	stop;
}

# Generic filter for newsletter senders
if anyof (
    address :contains :comparator "i;unicode-casemap" "From" "nyhetsbrev",
    address :contains :comparator "i;unicode-casemap" "From" "newsletter"
) {
  fileinto "Nyhetsbrev";
  expire "day" "180";
  stop;
}

# Filter for from:no-reply@revolut.com
if address :contains "From" "no-reply@revolut.com" {
  	fileinto "Nyhetsbrev";
	expire "day" "180";
    stop;
}

# Filter for from:hello@charlottemjelde.no
if address :contains "From" "hello@charlottemjelde.no" {
  	fileinto "Nyhetsbrev";
	expire "day" "180";
    stop;
}

# Filter for from:info@oslo-movement.no
if address :contains "From" "info@oslo-movement.no" {
  	fileinto "Nyhetsbrev";
	expire "day" "180";
    stop;
}

# Filter for to:oboe-ranger-calm@duck.com (Barnematbyen)
if address :contains "To" "oboe-ranger-calm@duck.com" {
  	fileinto "Nyhetsbrev";
	expire "day" "180";
    stop;
}

# Filter for from:stine@barebrabarnemat.no
if address :contains "From" "stine@barebrabarnemat.no" {
  	fileinto "Nyhetsbrev";
	expire "day" "180";
    stop;
}

# Filter for from:post@email.norskfamilie.no
if address :contains "From" "post@email.norskfamilie.no" {
  	fileinto "Nyhetsbrev";
	expire "day" "180";
    stop;
}

