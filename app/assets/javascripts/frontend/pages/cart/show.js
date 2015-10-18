(function($) {
    var pageId = 'frontend-carts-show';

    $(document).on("page:load#" + pageId, function(e) {
        var puppy_car_calculate = { //fandore购物车操作计算
            less_btn: $('.less'),
            add_btn: $('.add'),
            select_proNum: $('.total-num i'),
            select_all_btn: $('.total-checkbox'),
            pro_select: $('.pro-checkbox'),
            car_table_body: $('.cart-table tbody'),
            pro_num: $('.cart-table tbody tr').length, //获取有多少个产品
            pro_price_array: new Array(), //声明存储产品总价的数组
            total_price: $('.total-price i'),
            pro_swicth_array: new Array(),
            remove_btn: $('.remove-btn'),
            parse_int: function(obj) {
                return (parseFloat(obj.find('i').html())).toFixed(2);
            },
            accSub: function(arg1, arg2) {
                var r1, r2, m, n;
                try {
                    r1 = arg1.toString().split(".")[1].length
                } catch (e) {
                    r1 = 0
                }
                try {
                    r2 = arg2.toString().split(".")[1].length
                } catch (e) {
                    r2 = 0
                }
                m = Math.pow(10, Math.max(r1, r2));
                //last modify by deeka
                //动态控制精度长度
                n = (r1 >= r2) ? r1 : r2;
                return ((arg1 * m - arg2 * m) / m).toFixed(n);
            },
            accAdd: function(arg1, arg2) {
                var r1, r2, m;
                try {
                    r1 = arg1.toString().split(".")[1].length
                } catch (e) {
                    r1 = 0
                }
                try {
                    r2 = arg2.toString().split(".")[1].length
                } catch (e) {
                    r2 = 0
                }
                m = Math.pow(10, Math.max(r1, r2))
                return (arg1 * m + arg2 * m) / m
            },
            accMul: function(arg1, arg2) {
                var m = 0,
                    s1 = arg1.toString(),
                    s2 = arg2.toString();
                try {
                    m += s1.split(".")[1].length
                } catch (e) {}
                try {
                    m += s2.split(".")[1].length
                } catch (e) {}
                return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m)
            },
            select_pro: function() { //选择产品-总价变化
                var self = this;
                console.log(self.pro_select)
                self.pro_select.click(function(event) {
                    if ($(this).prop("checked")) {
                        var ind = $(this).parents('tr').index();
                        var pro_price = self.parse_int($(this).parents('tr').find('.price'));
                        self.pro_price_array[ind] = pro_price;
                        self.pro_swicth_array[ind] = true;
                        var select_proNum = 0;
                        var is_all = true;
                        for (var i = 0; i < self.pro_swicth_array.length; i++) {
                            if (!self.pro_swicth_array[i]) {
                                is_all = false;
                            } else {
                                select_proNum += 1;
                            }
                        }
                        if (is_all) {
                            self.select_all_btn.prop('checked', true);
                        }
                        self.cal_total_price(select_proNum);
                    } else {
                        var ind = $(this).parents('tr').index();
                        self.pro_price_array[ind] = 0.00;
                        self.select_all_btn.prop('checked', false);
                        self.pro_swicth_array[ind] = false;
                        var select_proNum = 0;
                        for (var i = 0; i < self.pro_swicth_array.length; i++) {
                            if (self.pro_swicth_array[i]) {
                                select_proNum += 1;
                            }
                        }
                        self.cal_total_price(select_proNum);
                    }
                });
                self.select_all_btn.click(function(event) {
                    if ($(this).prop("checked")) {
                        var $this = $(this);
                        self.pro_select.prop('checked', true);
                        for (var i = 0; i <= self.pro_num - 1; i++) { //遍历所有产品总价
                            self.pro_price_array[i] = self.parse_int(self.car_table_body.find('tr').eq(i).find('.price')); //存储进数组
                        };
                        for (var i = 0; i < self.pro_swicth_array.length; i++) {
                            self.pro_swicth_array[i] = true;
                        }
                        self.cal_total_price(self.pro_swicth_array.length);
                    } else {
                        var $this = $(this);
                        self.pro_select.prop('checked', false);
                        for (var i = 0; i <= self.pro_num - 1; i++) { //遍历所有产品总价
                            self.pro_price_array[i] = 0.00; //存储进数组
                        };
                        self.cal_total_price();
                        for (var i = 0; i < self.pro_swicth_array.length; i++) {
                            self.pro_swicth_array[i] = false;
                        }
                        self.cal_total_price(0);
                    }
                });
            },
            cal_total_price: function(select_proNum) {
                var self = this;
                var total_price = 0.00;
                for (var i = 0; i < self.pro_price_array.length; i++) { //遍历数组-加总和
                    total_price = self.accAdd(total_price, self.pro_price_array[i]).toFixed(2);
                }
                self.select_proNum.html(select_proNum);
                self.total_price.html(total_price);
            },
            remove_pro: function() {
                var self = this;
                self.remove_btn.click(function(e) {
                    console.log(1)
                    e.preventDefault();
                    var this_pro = $(this);
                    var ind = this_pro.parents('tr').index();
                    this_pro.parents('tr').addClass('remove');
                    setTimeout(function() {
                        this_pro.parents('tr').remove();
                        self.pro_price_array[ind] = 0;
                        self.pro_swicth_array[ind] = false;
                        for (var i = ind; i < self.pro_price_array.length; i++) {
                            self.pro_price_array[i] = self.pro_price_array[i + 1];
                            self.pro_swicth_array[i] = self.pro_swicth_array[i + 1];
                        }
                        self.pro_num -= 1;
                        self.pro_price_array.length = self.pro_num;
                        self.pro_swicth_array.length = self.pro_num;
                        self.cal_total_price();
                    }, 600);
                });
            },
            init: function() {
                var self = this;
                self.pro_price_array.length = self.pro_num; //设置-存储每个产品总价的数组-长度 = 产品品种数量
                self.pro_swicth_array.length = self.pro_num; //设置-存储每个产品是否是选中状态
                for (var i = 0; i <= self.pro_num - 1; i++) { //初始化数组为0
                    self.pro_price_array[i] = 0.00;
                }
                for (var i = 0; i <= self.pro_num - 1; i++) { //初始化选中状态为未选中状态
                    self.pro_swicth_array[i] = false;
                }
                self.select_pro();
                self.remove_pro();
            }
        };

        puppy_car_calculate.init();
    });
})(jQuery);
