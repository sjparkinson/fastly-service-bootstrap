#
# NOTE: The order of these includes is extremely important.
#

// The Fastly VCL boilerplate.
include "fastly-boilerplate.vcl";

// Redirects.
include "redirect-https.vcl";

// Synthetic responses.
include "synth-gtg.vcl";
