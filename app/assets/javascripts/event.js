// ページ更新でtag-it発火
$(document).ready(function() {
  $(".tag_form").tagit({
    tagLimit:10,
    singleField: true,
  });
  // 登録済みのタグを数える
  let tag_count = 10 - $(".tagit-choice").length
  $(".ui-widget-content.ui-autocomplete-input").attr(
    'placeholder','あと' + tag_count + '個');
})

// タグ入力で、placeholder を変更
$(document).on("keyup", '.tagit', function() {
  let tag_count = 10 - $(".tagit-choice").length
  $(".ui-widget-content.ui-autocomplete-input").attr(
  'placeholder','あと' + tag_count + '個');
});

$(".input").attr('placeholder','書き換え後のテキスト');
$(".input").removeAttr('placeholder');