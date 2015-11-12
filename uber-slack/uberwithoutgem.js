

// These are going to be fixed values. Currently based on Andrews credentials so lets change them before finishing up
var SERVER_TOKEN  = "5EqpeWmeYoc8YmzmRZxmkyprXUyBxjMqBCpyj-n3";
var CLIENT_ID     = "B4K8XNeyIq4qsI0QqCN8INGv7Ztn1XIL";
var CLIENT_SECRET = "iq6ILvHYlZA6I8RrufNB_fVXN5FZixkP99Tkbhv-";

BEARER_TOKEN = nil

function getEstimatesForUserLocation(latitude,longitude) {
  $.ajax({
    url: "https://api.uber.com/v1/estimates/price",
    headers: {
        Authorization: "Token " + uberServerToken
    },
    data: {
        start_latitude: latitude,
        start_longitude: longitude,
        end_latitude: partyLatitude,
        end_longitude: partyLongitude
    },
    success: function(result) {
        console.log(result);
    }
  });
}
