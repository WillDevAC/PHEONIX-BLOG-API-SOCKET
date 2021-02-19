// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"
import "../node_modules/materialize-css/dist/js/materialize";
// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
    import {Socket} from "phoenix"
    import socket from "./socket"
//
import "phoenix_html"

document.addEventListener('DOMContentLoaded', function () {
  var elems = document.querySelectorAll('.fixed-action-btn');
  M.FloatingActionButton.init(elems, {});

  var elems = document.querySelectorAll('.sidenav');
  M.Sidenav.init(elems, {});
});

