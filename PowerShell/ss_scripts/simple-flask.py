# import mimetypes
import os
import mimetypes
import flask

os.system("color")

app = flask.Flask(__name__, template_folder=".")


@app.route("/", defaults={"path": "index"})
@app.route("/<path:path>")
def main(path):
    try:
        with open(path, "rb") as f:
            t = mimetypes.guess_type(path, strict=True)[0]
            b = f.read()
            resp = flask.make_response(b)
            if t:
                resp.headers["content-type"] = t
            if not b:
                with open(path + ".html") as f:
                    return f.read()
            else:
                return resp
    except FileNotFoundError:
        return flask.abort(404)


app.run(host="0.0.0.0", debug=True)
