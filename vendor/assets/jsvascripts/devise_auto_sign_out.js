window.DeviceAutoSignOut = {
  interval: 6000,
  signInPath: '/account/sign_in',
  activePath: '/account/active'
};

$(function () {
  if (DeviceAutoSignOut.interval > 5000) {
    setInterval(checkStatusQuery, DeviceAutoSignOut.interval);
  } else {
    console.warn('DeviceAutoSignOut.interval is too small, minimum: 5000, current: ' + DeviceAutoSignOut.interval)
  }

  function checkStatusQuery() {
    $.ajax(DeviceAutoSignOut.activePath).always(checkStatusCallback);
  }

  function checkStatusCallback(jqXHR, textStatus) {
    if (jqXHR == 'false' || jqXHR.status == 401) {
      window.location.href = DeviceAutoSignOut.signInPath;
    }
  }
});
