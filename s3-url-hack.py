from mitmproxy import http

import re


# workaround for https://github.com/localstack/localstack/issues/2631
def request(flow: http.HTTPFlow) -> None:
    s3_match = re.match("(.*?)\.s3(\.dualstack)?[.-]([^.]*?)\.amazonaws\.com", flow.request.host)
    if s3_match:
        zone = s3_match.group(3)
        host = "s3.{}.amazonaws.com".format(zone)
        flow.request.host = host
        flow.request.headers["Host"] = host

        bucket = s3_match.group(1)
        flow.request.path = "/{}{}".format(bucket, flow.request.path)
