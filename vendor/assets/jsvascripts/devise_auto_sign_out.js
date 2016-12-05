window.DeviseAutoSignOut = {
  interval: 60000,
  signInPath: '/account/sign_in',
  activePath: '/account/active'
};

$(function () {
  setTimeout(function () {
    if (DeviseAutoSignOut.interval > 5000) {
      setInterval(checkStatusQuery, DeviseAutoSignOut.interval);
    } else {
      console.warn('DeviseAutoSignOut.interval is too small, minimum: 5000, current: ' + DeviseAutoSignOut.interval)
    }
  }, 0);

  function checkStatusQuery() {
    $.ajax(DeviseAutoSignOut.activePath).always(checkStatusCallback);
  }

  function checkStatusCallback(jqXHR, textStatus) {
    if (jqXHR == 'false' || jqXHR.status == 401) {
      window.location.href = DeviseAutoSignOut.signInPath;
    }
  }
});
