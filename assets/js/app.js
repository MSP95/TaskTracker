// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";
import $ from "jquery";
// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
function update_buttons() {
  $('.manage-button').each( (_, bb) => {
    let user_id = $(bb).data('user-id');
    let manage = $(bb).data('manage');
    if (manage == "") {
      $(bb).text("Manage");
    }

    else {
      $(bb).text("UnManage");
    }
  });
}

function set_button(user_id, value) {
  $('.manage-button').each( (_, bb) => {
    if (user_id == $(bb).data('user-id')) {
      $(bb).data('manage', value);
    }
  });
  update_buttons();
}

function manage(user_id) {
  let text = JSON.stringify({
    manage: {
      client_id: user_id,
      manager_id: current_user_id
    },
  });

  $.ajax(manage_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { set_button(user_id, resp.data.id); },
  });
}

function unmanage(user_id, manager_id) {
  $.ajax(manage_path + "/" + manager_id, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    success: () => { set_button(user_id, ""); },
  });
}

function manage_click(ev) {
  let btn = $(ev.target);
  let manager_id = btn.data('manage');
  let user_id = btn.data('user-id');

  if (manager_id == "") {
    manage(user_id);
  }
  else {
    unmanage(user_id, manager_id);
  }
}

function init_manage() {
  if (!$('.manage-button')) {
    return;
  }

  $(".manage-button").click(manage_click);

  update_buttons();
}
$(init_manage);
// ////////////////////////////////////////////////////////////////////////////
function update_time_button() {
  $('.time-button').each( (_, bb) => {
    let block_id = $(bb).data('block-id');
    // let manage = $(bb).data('manage');
    // console.log(block_id);
    if (block_id == "") {
      $(bb).text("Start");
    }
    else {
      $(bb).text("Stop");
    }

  });
}


function set_time_button(value) {
  // console.log(value);
  $('.time-button').data('block-id', value);
  // console.log($('.time-button').data('block-id'));

  update_time_button();
}

function stop_clock(task_id, block_id) {
  let end_time = new Date().toJSON();
  let text = JSON.stringify({
    context: "json",
    timeblock: {
      end_time: end_time

    },
  });

  $.ajax(timeblock_path + "/" + block_id, {
    method: "put",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: () => {
      set_time_button("");
    },
  });
}

function start_clock(task_id) {
  let start_time = new Date("October 13, 2014 11:13:00").toJSON();
  // console.log(start_time);
  let text = JSON.stringify({
    context: "json",
    timeblock: {
      task_id: task_id,
      user_id: current_user_id,
      start_time: start_time,
      end_time: "-"
    },
  });

  $.ajax(timeblock_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => {
      // console.log("inserted bitches")
      set_time_button(resp.data.id);
      // update_time_button();
      // set_time_button(task_id, "");
    },
  });
}

function start_click(ev) {
  let btn = $(ev.target);
  // let end_time = btn.data('end_time');
  let block_id = btn.data('block-id');
  let task_id = btn.data('task-id');
  // console.log(block_id == "")
  if (block_id == "") {
    start_clock(task_id);
  }
  else {
    stop_clock(task_id, block_id);
  }

}

function init_time() {
  if(!$('.time-button')) {
    return;
  }
  $(".time-button").click(start_click);
  // let block_id = btn.data('block-id');
  update_time_button();
}



$(init_time);
