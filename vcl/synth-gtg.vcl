sub vcl_recv {
    if (req.request == "GET" && req.url == "/__gtg") {
        error 700 "/__gtg Synthetic Response";
    }
}

sub vcl_error {
    // Synthetic /__gtg response.
    if (obj.status == 700) {
        set obj.status = 200;
        set obj.response = "OK";
        set obj.http.Content-Type = "text/plain";   

        synthetic {"OK"};

        return(deliver);
    }
}
