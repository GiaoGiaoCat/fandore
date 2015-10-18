(function($) {
    var pageId = 'frontend-orders-new';

    $(document).on("page:load#" + pageId, function(e) {
        //发表评价展开
        var review = $('.review-show'),
            prev_re;
        review.click(function() {
            var this_warp = $(this).parents('.table-review').find('.review-wrap');
            if (this_warp.is(":hidden")) {
                if (prev_re != undefined && prev_re != $(this)) prev_re.parents('.table-review').find('.review-wrap').slideUp();
                this_warp.slideDown();
            } else {
                this_warp.slideUp();
            }
            prev_re = $(this);
        });
        //select 美化
        $("select.select-style").msDropDown();
        $("select.select-user").msDropDown({
            mainCSS: 'dd2'
        });
        $("select.pro-select").msDropDown({
            mainCSS: 'ddpro'
        });
        //input框清除默认文字
        $('.input-test').bind({
            focus: function() {
                if (this.value == this.defaultValue) {
                    this.value = "";
                }
            },
            blur: function() {
                if (this.value == "") {
                    this.value = this.defaultValue;
                }
            }
        });
        //订单页面勾选展开
        $('#invoice').click(function() {
            if ($(this).attr("checked")) {
                $(this).removeAttr("checked");
                $('#invoice-con').slideUp("fast");
            } else {
                $(this).attr("checked", 'true')
                $('#invoice-con').slideDown("fast");
            }
        });
        $('#coupon').click(function() {
            if ($(this).attr("checked")) {
                $(this).removeAttr("checked");
                $('#coupon-con').slideUp("fast");
            } else {
                $(this).attr("checked", 'true')
                $('#coupon-con').slideDown("fast");
            }
        });
        $("#pay-banklist li").click(function() {
            $("#pay-banklist").find(".selected").removeClass();
            $(this).addClass("selected");
            return false;
        });
    });
})(jQuery);
