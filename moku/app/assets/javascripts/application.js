// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3

//= require rails-ujs
//= require activestorage
//= require_tree .

//= require popper
//= require bootstrap-sprockets

// はてなアイコン
$(document).ready(function () {
    $(function() {
      $('[data-toggle="popover"]').popover({
      trigger: 'hover',
      html: true,
    });
  })
})

// フラッシュ
$(function(){
  setTimeout("$('.alert').fadeOut('slow')", 3000)
})

// moku JUST NOW
function getJustNowDatas() {
  $.ajax({
      type: 'get', //routesに書いたajaxのためのURLに指定したリクエストメソッドを書く
      url: '/ajax/justnow.json' //routesに書いたajaxのためのURLを書く
  }).done(function (response, status) { //done === うまくいったら、 response === ブラウザから返ったデーター　status === successとかのステータス
      $('#justNowUl').empty() //mypage/index.htmlに書いてあるjustNowUlの中身を空っぽに
      const mokus = response //responseは↑の第一引数。ブラウザから返ってきたデーター
      for (let i = 0; i < mokus.length; i++) { //変数iを定義　mokusの要素の数より小さいうちはインクリメント
          const moku = mokus[i] //定数mokuを定義　mokusに入っている要素のi番目を取得して定数mokuへ
          const liElement = "<li>" + moku.format_created_at + "   " + moku.user.name + "さんが"  + "mokuを開始しました！" + "</li>" //定数liElementを定義　moku.idをリスト形式で出力
          $('#justNowUl').append(liElement) //justNowUlに対してliElementを追加　
      }
  })
}

$(document).ready(function () { //HTMLとか全部滞りなく読み取れたら、functionにかいたこと実行
  setInterval(getJustNowDatas, 5000) //setIntervalさん、5000ms === 5秒ごとに、getJustNowDatasを実行してね
})