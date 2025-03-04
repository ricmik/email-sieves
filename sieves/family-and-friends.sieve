require ["fileinto", "extlists", "vnd.proton.expire"];  

# Checks if sender is in personal address book with a "Familie" group association 
if header :list "from" ":addrbook:personal?label=Familie"   
{
    # This is purely extra protection in the event the sieves don't work as expected
    if hasexpiration
    {
        unexpire;
    }    
    fileinto "Familie";
    stop;
}

# Checks if sender is in personal address book with a "Venner" group association 
elsif header :list "from" ":addrbook:personal?label=Venner"   
{
    # This is purely extra protection in the event the sieves don't work as expected
    if hasexpiration
    {
        unexpire;
    }    
    fileinto "Venner";
    stop;
}