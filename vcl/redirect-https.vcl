sub vcl_recv {
    if (!req.http.Fastly-SSL) {
        error 701 "HTTPS Redirect";
    }
}

sub vcl_error {
    // HTTPS redirect.
    if (obj.status == 701) {
        set obj.status = 301;
        set obj.response = "Moved Permanently";
        set obj.http.Location = "https://" req.http.Fastly-Orig-Host req.url;

        synthetic {""};

        return(deliver);
    }
}
