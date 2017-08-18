const chai = require("chai");
const expect = chai.expect;

chai.use(require("chai-http"));

describe("/__gtg", () => {
  it('returns text/plain "OK"', () => {
    return chai
      .request(`https://e.ssl.fastly.net`)
      .get("/__gtg")
      .set("Host", process.env.FASTLY_SERVICE_HOST)
      .then(res => {
        expect(res).to.have.status(200);
        expect(res).to.be.text;
        expect(res.text).to.equal("OK");
      })
      .catch(err => {
        throw err;
      });
  });
});
