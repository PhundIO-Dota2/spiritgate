#include <hxcpp.h>

#include "hxMath.h"
#ifndef INCLUDED_Button
#include <Button.h>
#endif
#ifndef INCLUDED_DraggableWaystone
#include <DraggableWaystone.h>
#endif
#ifndef INCLUDED_List
#include <List.h>
#endif
#ifndef INCLUDED_MainState
#include <MainState.h>
#endif
#ifndef INCLUDED_PlacedWaystone
#include <PlacedWaystone.h>
#endif
#ifndef INCLUDED_Std
#include <Std.h>
#endif
#ifndef INCLUDED__List_ListIterator
#include <_List/ListIterator.h>
#endif
#ifndef INCLUDED_flixel_FlxBasic
#include <flixel/FlxBasic.h>
#endif
#ifndef INCLUDED_flixel_FlxCamera
#include <flixel/FlxCamera.h>
#endif
#ifndef INCLUDED_flixel_FlxG
#include <flixel/FlxG.h>
#endif
#ifndef INCLUDED_flixel_FlxObject
#include <flixel/FlxObject.h>
#endif
#ifndef INCLUDED_flixel_FlxSprite
#include <flixel/FlxSprite.h>
#endif
#ifndef INCLUDED_flixel_FlxState
#include <flixel/FlxState.h>
#endif
#ifndef INCLUDED_flixel_group_FlxGroup
#include <flixel/group/FlxGroup.h>
#endif
#ifndef INCLUDED_flixel_group_FlxTypedGroup
#include <flixel/group/FlxTypedGroup.h>
#endif
#ifndef INCLUDED_flixel_input_mouse_FlxMouse
#include <flixel/input/mouse/FlxMouse.h>
#endif
#ifndef INCLUDED_flixel_input_mouse_FlxMouseButton
#include <flixel/input/mouse/FlxMouseButton.h>
#endif
#ifndef INCLUDED_flixel_interfaces_IFlxDestroyable
#include <flixel/interfaces/IFlxDestroyable.h>
#endif
#ifndef INCLUDED_flixel_interfaces_IFlxInput
#include <flixel/interfaces/IFlxInput.h>
#endif
#ifndef INCLUDED_flixel_interfaces_IFlxPooled
#include <flixel/interfaces/IFlxPooled.h>
#endif
#ifndef INCLUDED_flixel_text_FlxText
#include <flixel/text/FlxText.h>
#endif
#ifndef INCLUDED_flixel_util_FlxCollision
#include <flixel/util/FlxCollision.h>
#endif
#ifndef INCLUDED_flixel_util_FlxPoint
#include <flixel/util/FlxPoint.h>
#endif
#ifndef INCLUDED_haxe_Http
#include <haxe/Http.h>
#endif
#ifndef INCLUDED_haxe_IMap
#include <haxe/IMap.h>
#endif
#ifndef INCLUDED_haxe_Log
#include <haxe/Log.h>
#endif
#ifndef INCLUDED_haxe_ds_StringMap
#include <haxe/ds/StringMap.h>
#endif
#ifndef INCLUDED_haxe_format_JsonParser
#include <haxe/format/JsonParser.h>
#endif

Void MainState_obj::__construct(Dynamic MaxSize)
{
HX_STACK_FRAME("MainState","new",0x18049bea,"MainState.new","MainState.hx",19,0x5634cec6)
HX_STACK_THIS(this)
HX_STACK_ARG(MaxSize,"MaxSize")
{
	HX_STACK_LINE(289)
	this->waystones = ::List_obj::__new();
	HX_STACK_LINE(152)
	this->tooltipAppearTimer = (int)0;
	HX_STACK_LINE(35)
	this->draggableWaystoneTexts = ::List_obj::__new();
	HX_STACK_LINE(34)
	this->draggableWaystones = ::List_obj::__new();
	HX_STACK_LINE(21)
	this->host = HX_HCSTRING("http://spiritgate.net","\x7d","\x31","\x43","\xb3");
	HX_STACK_LINE(19)
	Dynamic tmp = MaxSize;		HX_STACK_VAR(tmp,"tmp");
	HX_STACK_LINE(19)
	super::__construct(tmp);
}
;
	return null();
}

//MainState_obj::~MainState_obj() { }

Dynamic MainState_obj::__CreateEmpty() { return  new MainState_obj; }
hx::ObjectPtr< MainState_obj > MainState_obj::__new(Dynamic MaxSize)
{  hx::ObjectPtr< MainState_obj > _result_ = new MainState_obj();
	_result_->__construct(MaxSize);
	return _result_;}

Dynamic MainState_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< MainState_obj > _result_ = new MainState_obj();
	_result_->__construct(inArgs[0]);
	return _result_;}

Void MainState_obj::create( ){
{
		HX_STACK_FRAME("MainState","create",0xdbe6edb2,"MainState.create","MainState.hx",37,0x5634cec6)
		HX_STACK_THIS(this)
		HX_STACK_LINE(37)
		::MainState _g = hx::ObjectPtr<OBJ_>(this);		HX_STACK_VAR(_g,"_g");
		HX_STACK_LINE(38)
		::flixel::FlxG_obj::autoPause = false;
		HX_STACK_LINE(40)
		::flixel::FlxSprite tmp = ::flixel::FlxSprite_obj::__new((int)0,(int)0,null());		HX_STACK_VAR(tmp,"tmp");
		HX_STACK_LINE(40)
		this->mouse_collider_sprite = tmp;
		HX_STACK_LINE(41)
		::flixel::FlxSprite tmp1 = this->mouse_collider_sprite;		HX_STACK_VAR(tmp1,"tmp1");
		HX_STACK_LINE(41)
		tmp1->loadGraphic(HX_HCSTRING("assets/images/mouse_point.png","\x66","\xec","\x11","\xc4"),null(),null(),null(),null(),null());
		HX_STACK_LINE(42)
		::flixel::FlxSprite tmp2 = this->mouse_collider_sprite;		HX_STACK_VAR(tmp2,"tmp2");
		HX_STACK_LINE(42)
		this->add(tmp2);
		HX_STACK_LINE(44)
		::flixel::group::FlxGroup tmp3 = ::flixel::group::FlxGroup_obj::__new(null());		HX_STACK_VAR(tmp3,"tmp3");
		HX_STACK_LINE(44)
		this->z0 = tmp3;
		HX_STACK_LINE(45)
		::flixel::group::FlxGroup tmp4 = ::flixel::group::FlxGroup_obj::__new(null());		HX_STACK_VAR(tmp4,"tmp4");
		HX_STACK_LINE(45)
		this->z1 = tmp4;
		HX_STACK_LINE(46)
		::flixel::group::FlxGroup tmp5 = ::flixel::group::FlxGroup_obj::__new(null());		HX_STACK_VAR(tmp5,"tmp5");
		HX_STACK_LINE(46)
		this->z2 = tmp5;
		HX_STACK_LINE(47)
		::flixel::group::FlxGroup tmp6 = ::flixel::group::FlxGroup_obj::__new(null());		HX_STACK_VAR(tmp6,"tmp6");
		HX_STACK_LINE(47)
		this->z3 = tmp6;
		HX_STACK_LINE(48)
		::flixel::group::FlxGroup tmp7 = ::flixel::group::FlxGroup_obj::__new(null());		HX_STACK_VAR(tmp7,"tmp7");
		HX_STACK_LINE(48)
		this->z4 = tmp7;
		HX_STACK_LINE(50)
		::flixel::group::FlxGroup tmp8 = this->z0;		HX_STACK_VAR(tmp8,"tmp8");
		HX_STACK_LINE(50)
		this->add(tmp8);
		HX_STACK_LINE(51)
		::flixel::group::FlxGroup tmp9 = this->z1;		HX_STACK_VAR(tmp9,"tmp9");
		HX_STACK_LINE(51)
		this->add(tmp9);
		HX_STACK_LINE(52)
		::flixel::group::FlxGroup tmp10 = this->z2;		HX_STACK_VAR(tmp10,"tmp10");
		HX_STACK_LINE(52)
		this->add(tmp10);
		HX_STACK_LINE(53)
		::flixel::group::FlxGroup tmp11 = this->z3;		HX_STACK_VAR(tmp11,"tmp11");
		HX_STACK_LINE(53)
		this->add(tmp11);
		HX_STACK_LINE(54)
		::flixel::group::FlxGroup tmp12 = this->z4;		HX_STACK_VAR(tmp12,"tmp12");
		HX_STACK_LINE(54)
		this->add(tmp12);
		HX_STACK_LINE(56)
		::flixel::FlxSprite tmp13 = ::flixel::FlxSprite_obj::__new((int)-512,(int)-512,null());		HX_STACK_VAR(tmp13,"tmp13");
		HX_STACK_LINE(56)
		this->sidePanel = tmp13;
		HX_STACK_LINE(57)
		::flixel::FlxSprite tmp14 = this->sidePanel;		HX_STACK_VAR(tmp14,"tmp14");
		HX_STACK_LINE(57)
		tmp14->loadGraphic(HX_HCSTRING("assets/images/sidepanel.png","\x3d","\x0b","\x7e","\x3e"),null(),null(),null(),null(),null());
		HX_STACK_LINE(58)
		::flixel::group::FlxGroup tmp15 = this->z0;		HX_STACK_VAR(tmp15,"tmp15");
		HX_STACK_LINE(58)
		::flixel::FlxSprite tmp16 = this->sidePanel;		HX_STACK_VAR(tmp16,"tmp16");
		HX_STACK_LINE(58)
		tmp15->add(tmp16);
		HX_STACK_LINE(60)
		::flixel::FlxSprite tmp17 = ::flixel::FlxSprite_obj::__new((int)0,(int)0,null());		HX_STACK_VAR(tmp17,"tmp17");
		HX_STACK_LINE(60)
		::flixel::FlxSprite topPanel = tmp17;		HX_STACK_VAR(topPanel,"topPanel");
		HX_STACK_LINE(61)
		topPanel->loadGraphic(HX_HCSTRING("assets/images/toparea.png","\x12","\xd9","\x5d","\x4a"),null(),null(),null(),null(),null());
		HX_STACK_LINE(62)
		::flixel::group::FlxGroup tmp18 = this->z2;		HX_STACK_VAR(tmp18,"tmp18");
		HX_STACK_LINE(62)
		::flixel::FlxSprite tmp19 = topPanel;		HX_STACK_VAR(tmp19,"tmp19");
		HX_STACK_LINE(62)
		tmp18->add(tmp19);
		HX_STACK_LINE(64)
		int tmp20 = ::flixel::FlxG_obj::width;		HX_STACK_VAR(tmp20,"tmp20");
		HX_STACK_LINE(64)
		int tmp21 = (tmp20 - (int)512);		HX_STACK_VAR(tmp21,"tmp21");
		HX_STACK_LINE(64)
		::flixel::text::FlxText tmp22 = ::flixel::text::FlxText_obj::__new(tmp21,(int)0,(int)512,HX_HCSTRING("","\x00","\x00","\x00","\x00"),(int)14,null());		HX_STACK_VAR(tmp22,"tmp22");
		HX_STACK_LINE(64)
		this->stats_text = tmp22;
		HX_STACK_LINE(65)
		::flixel::group::FlxGroup tmp23 = this->z2;		HX_STACK_VAR(tmp23,"tmp23");
		HX_STACK_LINE(65)
		::flixel::text::FlxText tmp24 = this->stats_text;		HX_STACK_VAR(tmp24,"tmp24");
		HX_STACK_LINE(65)
		tmp23->add(tmp24);
		HX_STACK_LINE(67)
		int tmp25 = ::flixel::FlxG_obj::width;		HX_STACK_VAR(tmp25,"tmp25");
		HX_STACK_LINE(67)
		int tmp26 = (tmp25 - (int)512);		HX_STACK_VAR(tmp26,"tmp26");
		HX_STACK_LINE(67)
		int tmp27 = (tmp26 - (int)23);		HX_STACK_VAR(tmp27,"tmp27");
		HX_STACK_LINE(67)
		::flixel::FlxSprite tmp28 = ::flixel::FlxSprite_obj::__new(tmp27,(int)100,null());		HX_STACK_VAR(tmp28,"tmp28");
		HX_STACK_LINE(67)
		this->scrollbar_sprite = tmp28;
		HX_STACK_LINE(68)
		::flixel::FlxSprite tmp29 = this->scrollbar_sprite;		HX_STACK_VAR(tmp29,"tmp29");
		HX_STACK_LINE(68)
		tmp29->loadGraphic(HX_HCSTRING("assets/images/ScrollBar.png","\x56","\x39","\xb3","\x69"),null(),null(),null(),null(),null());
		HX_STACK_LINE(69)
		::flixel::group::FlxGroup tmp30 = this->z2;		HX_STACK_VAR(tmp30,"tmp30");
		HX_STACK_LINE(69)
		::flixel::FlxSprite tmp31 = this->scrollbar_sprite;		HX_STACK_VAR(tmp31,"tmp31");
		HX_STACK_LINE(69)
		tmp30->add(tmp31);
		HX_STACK_LINE(71)
		int tmp32 = ::flixel::FlxG_obj::width;		HX_STACK_VAR(tmp32,"tmp32");
		HX_STACK_LINE(71)
		int tmp33 = (tmp32 - (int)512);		HX_STACK_VAR(tmp33,"tmp33");
		HX_STACK_LINE(71)
		int tmp34 = ::flixel::FlxG_obj::height;		HX_STACK_VAR(tmp34,"tmp34");
		HX_STACK_LINE(71)
		int tmp35 = (tmp34 - (int)512);		HX_STACK_VAR(tmp35,"tmp35");
		HX_STACK_LINE(71)
		::flixel::FlxSprite tmp36 = ::flixel::FlxSprite_obj::__new(tmp33,tmp35,null());		HX_STACK_VAR(tmp36,"tmp36");
		HX_STACK_LINE(71)
		::flixel::FlxSprite grid = tmp36;		HX_STACK_VAR(grid,"grid");
		HX_STACK_LINE(72)
		grid->loadGraphic(HX_HCSTRING("assets/images/grid.png","\xac","\x49","\x4e","\xf4"),null(),null(),null(),null(),null());
		HX_STACK_LINE(73)
		::flixel::group::FlxGroup tmp37 = this->z0;		HX_STACK_VAR(tmp37,"tmp37");
		HX_STACK_LINE(73)
		::flixel::FlxSprite tmp38 = grid;		HX_STACK_VAR(tmp38,"tmp38");
		HX_STACK_LINE(73)
		tmp37->add(tmp38);
		HX_STACK_LINE(76)
		::String tmp39 = this->host;		HX_STACK_VAR(tmp39,"tmp39");
		HX_STACK_LINE(76)
		::String tmp40 = (tmp39 + HX_HCSTRING("api/get_all_waystones","\x61","\x10","\x7c","\x6c"));		HX_STACK_VAR(tmp40,"tmp40");
		HX_STACK_LINE(76)
		::haxe::Http tmp41 = ::haxe::Http_obj::__new(tmp40);		HX_STACK_VAR(tmp41,"tmp41");
		HX_STACK_LINE(76)
		::haxe::Http waystone_http_request = tmp41;		HX_STACK_VAR(waystone_http_request,"waystone_http_request");

		HX_BEGIN_LOCAL_FUNC_S1(hx::LocalFunc,_Function_1_1,::MainState,_g)
		int __ArgCount() const { return 1; }
		Void run(::String data){
			HX_STACK_FRAME("*","_Function_1_1",0x5200ed37,"*._Function_1_1","MainState.hx",80,0x5634cec6)
			HX_STACK_ARG(data,"data")
			{
				HX_STACK_LINE(81)
				::haxe::format::JsonParser tmp42 = ::haxe::format::JsonParser_obj::__new(data);		HX_STACK_VAR(tmp42,"tmp42");
				HX_STACK_LINE(81)
				Dynamic tmp43 = tmp42->parseRec();		HX_STACK_VAR(tmp43,"tmp43");
				HX_STACK_LINE(81)
				cpp::ArrayBase json_data = tmp43;		HX_STACK_VAR(json_data,"json_data");
				HX_STACK_LINE(82)
				int index = (int)-1;		HX_STACK_VAR(index,"index");
				HX_STACK_LINE(83)
				while((true)){
					HX_STACK_LINE(83)
					int tmp44 = ++(index);		HX_STACK_VAR(tmp44,"tmp44");
					HX_STACK_LINE(83)
					Dynamic tmp45 = json_data->__GetItem(tmp44);		HX_STACK_VAR(tmp45,"tmp45");
					HX_STACK_LINE(83)
					bool tmp46 = (tmp45 != null());		HX_STACK_VAR(tmp46,"tmp46");
					HX_STACK_LINE(83)
					bool tmp47 = !(tmp46);		HX_STACK_VAR(tmp47,"tmp47");
					HX_STACK_LINE(83)
					if ((tmp47)){
						HX_STACK_LINE(83)
						break;
					}
					HX_STACK_LINE(84)
					int tmp48 = (index * (int)100);		HX_STACK_VAR(tmp48,"tmp48");
					HX_STACK_LINE(84)
					int tmp49 = ((int)100 + tmp48);		HX_STACK_VAR(tmp49,"tmp49");
					HX_STACK_LINE(84)
					Dynamic tmp50 = json_data->__GetItem(index);		HX_STACK_VAR(tmp50,"tmp50");
					HX_STACK_LINE(84)
					::String tmp51 = tmp50->__Field(HX_HCSTRING("name","\x4b","\x72","\xff","\x48"), hx::paccDynamic );		HX_STACK_VAR(tmp51,"tmp51");
					HX_STACK_LINE(84)
					::flixel::text::FlxText tmp52 = ::flixel::text::FlxText_obj::__new((int)0,tmp49,(int)300,tmp51,(int)16,null());		HX_STACK_VAR(tmp52,"tmp52");
					HX_STACK_LINE(84)
					::flixel::text::FlxText text = tmp52;		HX_STACK_VAR(text,"text");
					HX_STACK_LINE(85)
					::flixel::text::FlxText tmp53 = text;		HX_STACK_VAR(tmp53,"tmp53");
					HX_STACK_LINE(85)
					_g->z1->add(tmp53);
					HX_STACK_LINE(86)
					::flixel::text::FlxText tmp54 = text;		HX_STACK_VAR(tmp54,"tmp54");
					HX_STACK_LINE(86)
					_g->draggableWaystoneTexts->add(tmp54);
					HX_STACK_LINE(88)
					Dynamic tmp55 = json_data->__GetItem(index);		HX_STACK_VAR(tmp55,"tmp55");
					HX_STACK_LINE(88)
					::String tmp56;		HX_STACK_VAR(tmp56,"tmp56");
					HX_STACK_LINE(88)
					tmp56 = hx::TCast< ::String >::cast(tmp55->__Field(HX_HCSTRING("properties","\xf3","\xfb","\x0e","\x61"), hx::paccDynamic ));
					HX_STACK_LINE(88)
					::String properties = tmp56;		HX_STACK_VAR(properties,"properties");
					HX_STACK_LINE(90)
					int tmp57 = (index * (int)100);		HX_STACK_VAR(tmp57,"tmp57");
					HX_STACK_LINE(90)
					int tmp58 = ((int)100 + tmp57);		HX_STACK_VAR(tmp58,"tmp58");
					HX_STACK_LINE(90)
					int tmp59 = (tmp58 + (int)22);		HX_STACK_VAR(tmp59,"tmp59");
					HX_STACK_LINE(90)
					::MainState tmp60 = _g;		HX_STACK_VAR(tmp60,"tmp60");
					HX_STACK_LINE(90)
					Dynamic tmp61 = json_data->__GetItem(index);		HX_STACK_VAR(tmp61,"tmp61");
					HX_STACK_LINE(90)
					::String tmp62 = tmp61->__Field(HX_HCSTRING("shape","\x21","\xe3","\x1c","\x7c"), hx::paccDynamic );		HX_STACK_VAR(tmp62,"tmp62");
					HX_STACK_LINE(90)
					Dynamic tmp63 = json_data->__GetItem(index);		HX_STACK_VAR(tmp63,"tmp63");
					HX_STACK_LINE(90)
					::String tmp64 = tmp63->__Field(HX_HCSTRING("name","\x4b","\x72","\xff","\x48"), hx::paccDynamic );		HX_STACK_VAR(tmp64,"tmp64");
					HX_STACK_LINE(90)
					::DraggableWaystone tmp65 = ::DraggableWaystone_obj::__new((int)5,tmp59,tmp60,tmp62,properties.split(HX_HCSTRING(";","\x3b","\x00","\x00","\x00")),tmp64);		HX_STACK_VAR(tmp65,"tmp65");
					HX_STACK_LINE(90)
					::DraggableWaystone block = tmp65;		HX_STACK_VAR(block,"block");
					HX_STACK_LINE(91)
					::DraggableWaystone tmp66 = block;		HX_STACK_VAR(tmp66,"tmp66");
					HX_STACK_LINE(91)
					_g->draggableWaystones->add(tmp66);
				}
			}
			return null();
		}
		HX_END_LOCAL_FUNC1((void))

		HX_STACK_LINE(80)
		waystone_http_request->onData =  Dynamic(new _Function_1_1(_g));
		HX_STACK_LINE(94)
		waystone_http_request->request(null());
		HX_STACK_LINE(96)
		::String tmp42 = this->host;		HX_STACK_VAR(tmp42,"tmp42");
		HX_STACK_LINE(96)
		::String tmp43 = (tmp42 + HX_HCSTRING("api/get_loadout/1","\xac","\x9d","\x11","\x1d"));		HX_STACK_VAR(tmp43,"tmp43");
		HX_STACK_LINE(96)
		::haxe::Http tmp44 = ::haxe::Http_obj::__new(tmp43);		HX_STACK_VAR(tmp44,"tmp44");
		HX_STACK_LINE(96)
		::haxe::Http loadout_http_request = tmp44;		HX_STACK_VAR(loadout_http_request,"loadout_http_request");

		HX_BEGIN_LOCAL_FUNC_S1(hx::LocalFunc,_Function_1_2,::MainState,_g)
		int __ArgCount() const { return 1; }
		Void run(::String data){
			HX_STACK_FRAME("*","_Function_1_2",0x5200ed38,"*._Function_1_2","MainState.hx",97,0x5634cec6)
			HX_STACK_ARG(data,"data")
			{
				HX_STACK_LINE(98)
				bool tmp45 = (data != HX_HCSTRING("error","\xc8","\xcb","\x29","\x73"));		HX_STACK_VAR(tmp45,"tmp45");
				HX_STACK_LINE(98)
				if ((tmp45)){
					HX_STACK_LINE(99)
					Array< ::String > stones_data = data.split(HX_HCSTRING(";","\x3b","\x00","\x00","\x00"));		HX_STACK_VAR(stones_data,"stones_data");
					HX_STACK_LINE(100)
					{
						HX_STACK_LINE(100)
						int _g1 = (int)0;		HX_STACK_VAR(_g1,"_g1");
						HX_STACK_LINE(100)
						while((true)){
							HX_STACK_LINE(100)
							bool tmp46 = (_g1 < stones_data->length);		HX_STACK_VAR(tmp46,"tmp46");
							HX_STACK_LINE(100)
							bool tmp47 = !(tmp46);		HX_STACK_VAR(tmp47,"tmp47");
							HX_STACK_LINE(100)
							if ((tmp47)){
								HX_STACK_LINE(100)
								break;
							}
							HX_STACK_LINE(100)
							::String tmp48 = stones_data->__get(_g1);		HX_STACK_VAR(tmp48,"tmp48");
							HX_STACK_LINE(100)
							::String stone_data = tmp48;		HX_STACK_VAR(stone_data,"stone_data");
							HX_STACK_LINE(100)
							++(_g1);
							HX_STACK_LINE(101)
							::String tmp49 = stone_data.split(HX_HCSTRING("@","\x40","\x00","\x00","\x00"))->__get((int)0);		HX_STACK_VAR(tmp49,"tmp49");
							HX_STACK_LINE(101)
							::String name = tmp49;		HX_STACK_VAR(name,"name");
							HX_STACK_LINE(102)
							::String tmp50 = stone_data.split(HX_HCSTRING("@","\x40","\x00","\x00","\x00"))->__get((int)1);		HX_STACK_VAR(tmp50,"tmp50");
							HX_STACK_LINE(102)
							::String stone_pos_data = tmp50;		HX_STACK_VAR(stone_pos_data,"stone_pos_data");
							HX_STACK_LINE(103)
							::String tmp51 = stone_pos_data.split(HX_HCSTRING(",","\x2c","\x00","\x00","\x00"))->__get((int)0);		HX_STACK_VAR(tmp51,"tmp51");
							HX_STACK_LINE(103)
							Dynamic tmp52 = ::Std_obj::parseInt(tmp51);		HX_STACK_VAR(tmp52,"tmp52");
							HX_STACK_LINE(103)
							Dynamic stone_x = tmp52;		HX_STACK_VAR(stone_x,"stone_x");
							HX_STACK_LINE(104)
							::String tmp53 = stone_pos_data.split(HX_HCSTRING(",","\x2c","\x00","\x00","\x00"))->__get((int)1);		HX_STACK_VAR(tmp53,"tmp53");
							HX_STACK_LINE(104)
							Dynamic tmp54 = ::Std_obj::parseInt(tmp53);		HX_STACK_VAR(tmp54,"tmp54");
							HX_STACK_LINE(104)
							Dynamic stone_y = tmp54;		HX_STACK_VAR(stone_y,"stone_y");
							HX_STACK_LINE(105)
							::String tmp55 = stone_pos_data.split(HX_HCSTRING(",","\x2c","\x00","\x00","\x00"))->__get((int)2);		HX_STACK_VAR(tmp55,"tmp55");
							HX_STACK_LINE(105)
							Dynamic tmp56 = ::Std_obj::parseInt(tmp55);		HX_STACK_VAR(tmp56,"tmp56");
							HX_STACK_LINE(105)
							Dynamic stone_angle = tmp56;		HX_STACK_VAR(stone_angle,"stone_angle");
							HX_STACK_LINE(107)
							::String stone_shape = HX_HCSTRING("","\x00","\x00","\x00","\x00");		HX_STACK_VAR(stone_shape,"stone_shape");
							HX_STACK_LINE(108)
							Array< ::String > stone_properties = Array_obj< ::String >::__new();		HX_STACK_VAR(stone_properties,"stone_properties");
							HX_STACK_LINE(110)
							{
								HX_STACK_LINE(110)
								::_List::ListIterator tmp57 = ::_List::ListIterator_obj::__new(_g->draggableWaystones->h);		HX_STACK_VAR(tmp57,"tmp57");
								HX_STACK_LINE(110)
								::_List::ListIterator _g11 = tmp57;		HX_STACK_VAR(_g11,"_g11");
								HX_STACK_LINE(110)
								while((true)){
									HX_STACK_LINE(110)
									bool tmp58 = (_g11->head != null());		HX_STACK_VAR(tmp58,"tmp58");
									HX_STACK_LINE(110)
									bool tmp59 = !(tmp58);		HX_STACK_VAR(tmp59,"tmp59");
									HX_STACK_LINE(110)
									if ((tmp59)){
										HX_STACK_LINE(110)
										break;
									}
									HX_STACK_LINE(110)
									Dynamic tmp60;		HX_STACK_VAR(tmp60,"tmp60");
									HX_STACK_LINE(110)
									{
										HX_STACK_LINE(110)
										Dynamic tmp61 = _g11->head->__GetItem((int)0);		HX_STACK_VAR(tmp61,"tmp61");
										HX_STACK_LINE(110)
										_g11->val = tmp61;
										HX_STACK_LINE(110)
										Dynamic tmp62 = _g11->head->__GetItem((int)1);		HX_STACK_VAR(tmp62,"tmp62");
										HX_STACK_LINE(110)
										_g11->head = tmp62;
										HX_STACK_LINE(110)
										tmp60 = _g11->val;
									}
									HX_STACK_LINE(110)
									::DraggableWaystone dragstone = ((::DraggableWaystone)(tmp60));		HX_STACK_VAR(dragstone,"dragstone");
									HX_STACK_LINE(111)
									bool tmp61 = (dragstone->name == name);		HX_STACK_VAR(tmp61,"tmp61");
									HX_STACK_LINE(111)
									if ((tmp61)){
										HX_STACK_LINE(112)
										stone_shape = dragstone->shape;
										HX_STACK_LINE(113)
										stone_properties = dragstone->stone_properties;
									}
								}
							}
							HX_STACK_LINE(117)
							int tmp57 = ::flixel::FlxG_obj::width;		HX_STACK_VAR(tmp57,"tmp57");
							HX_STACK_LINE(117)
							int tmp58 = (tmp57 - (int)512);		HX_STACK_VAR(tmp58,"tmp58");
							HX_STACK_LINE(117)
							int tmp59 = (stone_x * (int)128);		HX_STACK_VAR(tmp59,"tmp59");
							HX_STACK_LINE(117)
							int tmp60 = (tmp58 + tmp59);		HX_STACK_VAR(tmp60,"tmp60");
							HX_STACK_LINE(117)
							int tmp61 = ::flixel::FlxG_obj::height;		HX_STACK_VAR(tmp61,"tmp61");
							HX_STACK_LINE(117)
							int tmp62 = (tmp61 - (int)512);		HX_STACK_VAR(tmp62,"tmp62");
							HX_STACK_LINE(117)
							int tmp63 = (stone_y * (int)128);		HX_STACK_VAR(tmp63,"tmp63");
							HX_STACK_LINE(117)
							int tmp64 = (tmp62 + tmp63);		HX_STACK_VAR(tmp64,"tmp64");
							HX_STACK_LINE(117)
							::MainState tmp65 = _g;		HX_STACK_VAR(tmp65,"tmp65");
							HX_STACK_LINE(117)
							::String tmp66 = stone_shape;		HX_STACK_VAR(tmp66,"tmp66");
							HX_STACK_LINE(117)
							::String tmp67 = name;		HX_STACK_VAR(tmp67,"tmp67");
							HX_STACK_LINE(117)
							::PlacedWaystone tmp68 = ::PlacedWaystone_obj::__new(tmp60,tmp64,tmp65,tmp66,stone_properties,tmp67);		HX_STACK_VAR(tmp68,"tmp68");
							HX_STACK_LINE(117)
							::PlacedWaystone placed_stone = tmp68;		HX_STACK_VAR(placed_stone,"placed_stone");
							HX_STACK_LINE(118)
							Dynamic tmp69 = stone_angle;		HX_STACK_VAR(tmp69,"tmp69");
							HX_STACK_LINE(118)
							placed_stone->set_angle(tmp69);
							HX_STACK_LINE(119)
							::PlacedWaystone tmp70 = placed_stone;		HX_STACK_VAR(tmp70,"tmp70");
							HX_STACK_LINE(119)
							_g->waystones->add(tmp70);
						}
					}
				}
			}
			return null();
		}
		HX_END_LOCAL_FUNC1((void))

		HX_STACK_LINE(97)
		loadout_http_request->onData =  Dynamic(new _Function_1_2(_g));
		HX_STACK_LINE(123)
		loadout_http_request->request(null());
		HX_STACK_LINE(125)
		int tmp45 = ::flixel::FlxG_obj::width;		HX_STACK_VAR(tmp45,"tmp45");
		HX_STACK_LINE(125)
		int tmp46 = (tmp45 - (int)140);		HX_STACK_VAR(tmp46,"tmp46");
		HX_STACK_LINE(125)
		int tmp47 = ::flixel::FlxG_obj::height;		HX_STACK_VAR(tmp47,"tmp47");
		HX_STACK_LINE(125)
		int tmp48 = (tmp47 - (int)512);		HX_STACK_VAR(tmp48,"tmp48");
		HX_STACK_LINE(125)
		int tmp49 = (tmp48 - (int)50);		HX_STACK_VAR(tmp49,"tmp49");

		HX_BEGIN_LOCAL_FUNC_S1(hx::LocalFunc,_Function_1_3,::MainState,_g)
		int __ArgCount() const { return 0; }
		Void run(){
			HX_STACK_FRAME("*","_Function_1_3",0x5200ed39,"*._Function_1_3","MainState.hx",125,0x5634cec6)
			{
				HX_STACK_LINE(126)
				::String tmp50 = (_g->host + HX_HCSTRING("api/set_loadout/1","\xb8","\x7f","\x17","\x62"));		HX_STACK_VAR(tmp50,"tmp50");
				HX_STACK_LINE(126)
				::haxe::Http tmp51 = ::haxe::Http_obj::__new(tmp50);		HX_STACK_VAR(tmp51,"tmp51");
				HX_STACK_LINE(126)
				::haxe::Http submit_http_request = tmp51;		HX_STACK_VAR(submit_http_request,"submit_http_request");
				HX_STACK_LINE(127)
				::String submit_data = HX_HCSTRING("","\x00","\x00","\x00","\x00");		HX_STACK_VAR(submit_data,"submit_data");
				HX_STACK_LINE(128)
				{
					HX_STACK_LINE(128)
					::_List::ListIterator tmp52 = ::_List::ListIterator_obj::__new(_g->waystones->h);		HX_STACK_VAR(tmp52,"tmp52");
					HX_STACK_LINE(128)
					::_List::ListIterator _g1 = tmp52;		HX_STACK_VAR(_g1,"_g1");
					HX_STACK_LINE(128)
					while((true)){
						HX_STACK_LINE(128)
						bool tmp53 = (_g1->head != null());		HX_STACK_VAR(tmp53,"tmp53");
						HX_STACK_LINE(128)
						bool tmp54 = !(tmp53);		HX_STACK_VAR(tmp54,"tmp54");
						HX_STACK_LINE(128)
						if ((tmp54)){
							HX_STACK_LINE(128)
							break;
						}
						HX_STACK_LINE(128)
						Dynamic tmp55;		HX_STACK_VAR(tmp55,"tmp55");
						HX_STACK_LINE(128)
						{
							HX_STACK_LINE(128)
							Dynamic tmp56 = _g1->head->__GetItem((int)0);		HX_STACK_VAR(tmp56,"tmp56");
							HX_STACK_LINE(128)
							_g1->val = tmp56;
							HX_STACK_LINE(128)
							Dynamic tmp57 = _g1->head->__GetItem((int)1);		HX_STACK_VAR(tmp57,"tmp57");
							HX_STACK_LINE(128)
							_g1->head = tmp57;
							HX_STACK_LINE(128)
							tmp55 = _g1->val;
						}
						HX_STACK_LINE(128)
						::PlacedWaystone waystone = ((::PlacedWaystone)(tmp55));		HX_STACK_VAR(waystone,"waystone");
						HX_STACK_LINE(129)
						Float tmp56 = waystone->x;		HX_STACK_VAR(tmp56,"tmp56");
						HX_STACK_LINE(129)
						int tmp57 = ::flixel::FlxG_obj::width;		HX_STACK_VAR(tmp57,"tmp57");
						HX_STACK_LINE(129)
						Float tmp58 = (tmp56 - tmp57);		HX_STACK_VAR(tmp58,"tmp58");
						HX_STACK_LINE(129)
						Float tmp59 = (tmp58 + (int)512);		HX_STACK_VAR(tmp59,"tmp59");
						HX_STACK_LINE(129)
						Float tmp60 = (Float(tmp59) / Float((int)128));		HX_STACK_VAR(tmp60,"tmp60");
						HX_STACK_LINE(129)
						int tmp61 = ::Math_obj::round(tmp60);		HX_STACK_VAR(tmp61,"tmp61");
						HX_STACK_LINE(129)
						int grid_x = tmp61;		HX_STACK_VAR(grid_x,"grid_x");
						HX_STACK_LINE(130)
						Float tmp62 = waystone->y;		HX_STACK_VAR(tmp62,"tmp62");
						HX_STACK_LINE(130)
						int tmp63 = ::flixel::FlxG_obj::height;		HX_STACK_VAR(tmp63,"tmp63");
						HX_STACK_LINE(130)
						Float tmp64 = (tmp62 - tmp63);		HX_STACK_VAR(tmp64,"tmp64");
						HX_STACK_LINE(130)
						Float tmp65 = (tmp64 + (int)512);		HX_STACK_VAR(tmp65,"tmp65");
						HX_STACK_LINE(130)
						Float tmp66 = (Float(tmp65) / Float((int)128));		HX_STACK_VAR(tmp66,"tmp66");
						HX_STACK_LINE(130)
						int tmp67 = ::Math_obj::round(tmp66);		HX_STACK_VAR(tmp67,"tmp67");
						HX_STACK_LINE(130)
						int grid_y = tmp67;		HX_STACK_VAR(grid_y,"grid_y");
						HX_STACK_LINE(131)
						::String tmp68 = (waystone->name + HX_HCSTRING("@","\x40","\x00","\x00","\x00"));		HX_STACK_VAR(tmp68,"tmp68");
						HX_STACK_LINE(131)
						int tmp69 = grid_x;		HX_STACK_VAR(tmp69,"tmp69");
						HX_STACK_LINE(131)
						::String tmp70 = (tmp68 + tmp69);		HX_STACK_VAR(tmp70,"tmp70");
						HX_STACK_LINE(131)
						::String tmp71 = (tmp70 + HX_HCSTRING(",","\x2c","\x00","\x00","\x00"));		HX_STACK_VAR(tmp71,"tmp71");
						HX_STACK_LINE(131)
						int tmp72 = grid_y;		HX_STACK_VAR(tmp72,"tmp72");
						HX_STACK_LINE(131)
						::String tmp73 = (tmp71 + tmp72);		HX_STACK_VAR(tmp73,"tmp73");
						HX_STACK_LINE(131)
						::String tmp74 = (tmp73 + HX_HCSTRING(",","\x2c","\x00","\x00","\x00"));		HX_STACK_VAR(tmp74,"tmp74");
						HX_STACK_LINE(131)
						Float tmp75 = hx::Mod(waystone->angle,(int)360);		HX_STACK_VAR(tmp75,"tmp75");
						HX_STACK_LINE(131)
						::String tmp76 = (tmp74 + tmp75);		HX_STACK_VAR(tmp76,"tmp76");
						HX_STACK_LINE(131)
						::String tmp77 = (tmp76 + HX_HCSTRING(";","\x3b","\x00","\x00","\x00"));		HX_STACK_VAR(tmp77,"tmp77");
						HX_STACK_LINE(131)
						hx::AddEq(submit_data,tmp77);
					}
				}
				HX_STACK_LINE(134)
				::String tmp52 = submit_data;		HX_STACK_VAR(tmp52,"tmp52");
				HX_STACK_LINE(134)
				submit_http_request->setParameter(HX_HCSTRING("loadout","\x28","\x62","\xf7","\x08"),tmp52);

				HX_BEGIN_LOCAL_FUNC_S0(hx::LocalFunc,_Function_2_1)
				int __ArgCount() const { return 1; }
				Void run(::String data){
					HX_STACK_FRAME("*","_Function_2_1",0x5201af78,"*._Function_2_1","MainState.hx",135,0x5634cec6)
					HX_STACK_ARG(data,"data")
					{
						HX_STACK_LINE(136)
						bool tmp53 = (data == HX_HCSTRING("success","\xc3","\x25","\x4e","\xb8"));		HX_STACK_VAR(tmp53,"tmp53");
						HX_STACK_LINE(136)
						if ((tmp53)){
							HX_STACK_LINE(137)
							Dynamic tmp54 = hx::SourceInfo(HX_HCSTRING("MainState.hx","\xc6","\xce","\x34","\x56"),137,HX_HCSTRING("MainState","\xf8","\x1e","\x82","\x3f"),HX_HCSTRING("create","\xfc","\x66","\x0f","\x7c"));		HX_STACK_VAR(tmp54,"tmp54");
							HX_STACK_LINE(137)
							::haxe::Log_obj::trace(HX_HCSTRING("Success","\xa3","\x4d","\x9f","\x85"),tmp54);
						}
					}
					return null();
				}
				HX_END_LOCAL_FUNC1((void))

				HX_STACK_LINE(135)
				submit_http_request->onData =  Dynamic(new _Function_2_1());
				HX_STACK_LINE(140)
				submit_http_request->request(false);
			}
			return null();
		}
		HX_END_LOCAL_FUNC0((void))

		HX_STACK_LINE(125)
		::Button tmp50 = ::Button_obj::__new(tmp46,tmp49,hx::ObjectPtr<OBJ_>(this),HX_HCSTRING("Save","\x5d","\xb7","\x26","\x37"), Dynamic(new _Function_1_3(_g)));		HX_STACK_VAR(tmp50,"tmp50");
		HX_STACK_LINE(125)
		::Button button = tmp50;		HX_STACK_VAR(button,"button");
		HX_STACK_LINE(143)
		this->super::create();
	}
return null();
}


Void MainState_obj::destroy( ){
{
		HX_STACK_FRAME("MainState","destroy",0xa1448584,"MainState.destroy","MainState.hx",149,0x5634cec6)
		HX_STACK_THIS(this)
		HX_STACK_LINE(149)
		this->super::destroy();
	}
return null();
}


Void MainState_obj::update( ){
{
		HX_STACK_FRAME("MainState","update",0xe6dd0cbf,"MainState.update","MainState.hx",155,0x5634cec6)
		HX_STACK_THIS(this)
		HX_STACK_LINE(156)
		this->super::update();
		HX_STACK_LINE(158)
		::flixel::text::FlxText tmp = this->stats_text;		HX_STACK_VAR(tmp,"tmp");
		HX_STACK_LINE(158)
		tmp->set_text(HX_HCSTRING("Loadout Stats:\n","\x37","\xec","\x79","\x42"));
		HX_STACK_LINE(159)
		::haxe::ds::StringMap tmp1;		HX_STACK_VAR(tmp1,"tmp1");
		HX_STACK_LINE(159)
		{
			HX_STACK_LINE(159)
			::haxe::ds::StringMap tmp2 = ::haxe::ds::StringMap_obj::__new();		HX_STACK_VAR(tmp2,"tmp2");
			HX_STACK_LINE(159)
			::haxe::ds::StringMap tmp3 = tmp2;		HX_STACK_VAR(tmp3,"tmp3");
			HX_STACK_LINE(159)
			tmp1 = tmp3;
		}
		HX_STACK_LINE(159)
		::haxe::ds::StringMap properties = tmp1;		HX_STACK_VAR(properties,"properties");
		HX_STACK_LINE(160)
		{
			HX_STACK_LINE(160)
			::List tmp2 = this->waystones;		HX_STACK_VAR(tmp2,"tmp2");
			HX_STACK_LINE(160)
			::_List::ListIterator tmp3 = ::_List::ListIterator_obj::__new(tmp2->h);		HX_STACK_VAR(tmp3,"tmp3");
			HX_STACK_LINE(160)
			::_List::ListIterator _g = tmp3;		HX_STACK_VAR(_g,"_g");
			HX_STACK_LINE(160)
			while((true)){
				HX_STACK_LINE(160)
				bool tmp4 = (_g->head != null());		HX_STACK_VAR(tmp4,"tmp4");
				HX_STACK_LINE(160)
				bool tmp5 = !(tmp4);		HX_STACK_VAR(tmp5,"tmp5");
				HX_STACK_LINE(160)
				if ((tmp5)){
					HX_STACK_LINE(160)
					break;
				}
				HX_STACK_LINE(160)
				Dynamic tmp6;		HX_STACK_VAR(tmp6,"tmp6");
				HX_STACK_LINE(160)
				{
					HX_STACK_LINE(160)
					Dynamic tmp7 = _g->head->__GetItem((int)0);		HX_STACK_VAR(tmp7,"tmp7");
					HX_STACK_LINE(160)
					_g->val = tmp7;
					HX_STACK_LINE(160)
					Dynamic tmp8 = _g->head->__GetItem((int)1);		HX_STACK_VAR(tmp8,"tmp8");
					HX_STACK_LINE(160)
					_g->head = tmp8;
					HX_STACK_LINE(160)
					tmp6 = _g->val;
				}
				HX_STACK_LINE(160)
				::PlacedWaystone waystone = ((::PlacedWaystone)(tmp6));		HX_STACK_VAR(waystone,"waystone");
				HX_STACK_LINE(161)
				::PlacedWaystone tmp7;		HX_STACK_VAR(tmp7,"tmp7");
				HX_STACK_LINE(161)
				tmp7 = hx::TCast< ::PlacedWaystone >::cast(waystone);
				HX_STACK_LINE(161)
				::PlacedWaystone stone = tmp7;		HX_STACK_VAR(stone,"stone");
				HX_STACK_LINE(162)
				{
					HX_STACK_LINE(162)
					int _g1 = (int)0;		HX_STACK_VAR(_g1,"_g1");
					HX_STACK_LINE(162)
					Array< ::String > _g11 = stone->stone_properties;		HX_STACK_VAR(_g11,"_g11");
					HX_STACK_LINE(162)
					while((true)){
						HX_STACK_LINE(162)
						bool tmp8 = (_g1 < _g11->length);		HX_STACK_VAR(tmp8,"tmp8");
						HX_STACK_LINE(162)
						bool tmp9 = !(tmp8);		HX_STACK_VAR(tmp9,"tmp9");
						HX_STACK_LINE(162)
						if ((tmp9)){
							HX_STACK_LINE(162)
							break;
						}
						HX_STACK_LINE(162)
						::String tmp10 = _g11->__get(_g1);		HX_STACK_VAR(tmp10,"tmp10");
						HX_STACK_LINE(162)
						::String property = tmp10;		HX_STACK_VAR(property,"property");
						HX_STACK_LINE(162)
						++(_g1);
						HX_STACK_LINE(163)
						::String tmp11;		HX_STACK_VAR(tmp11,"tmp11");
						HX_STACK_LINE(163)
						tmp11 = hx::TCast< ::String >::cast(property);
						HX_STACK_LINE(163)
						::String stone_property = tmp11;		HX_STACK_VAR(stone_property,"stone_property");
						HX_STACK_LINE(164)
						bool tmp12;		HX_STACK_VAR(tmp12,"tmp12");
						HX_STACK_LINE(164)
						{
							HX_STACK_LINE(164)
							::String tmp13 = stone_property.split(HX_HCSTRING(":","\x3a","\x00","\x00","\x00"))->__get((int)0);		HX_STACK_VAR(tmp13,"tmp13");
							HX_STACK_LINE(164)
							::String key = tmp13;		HX_STACK_VAR(key,"key");
							HX_STACK_LINE(164)
							::String tmp14 = key;		HX_STACK_VAR(tmp14,"tmp14");
							HX_STACK_LINE(164)
							tmp12 = properties->exists(tmp14);
						}
						HX_STACK_LINE(164)
						bool tmp13 = !(tmp12);		HX_STACK_VAR(tmp13,"tmp13");
						HX_STACK_LINE(164)
						if ((tmp13)){
							HX_STACK_LINE(165)
							::String tmp14 = stone_property.split(HX_HCSTRING(":","\x3a","\x00","\x00","\x00"))->__get((int)0);		HX_STACK_VAR(tmp14,"tmp14");
							HX_STACK_LINE(165)
							::String key = tmp14;		HX_STACK_VAR(key,"key");
							HX_STACK_LINE(165)
							::String tmp15 = key;		HX_STACK_VAR(tmp15,"tmp15");
							HX_STACK_LINE(165)
							properties->set(tmp15,HX_HCSTRING("0","\x30","\x00","\x00","\x00"));
						}
						HX_STACK_LINE(167)
						::String tmp14 = stone_property.split(HX_HCSTRING(":","\x3a","\x00","\x00","\x00"))->__get((int)0);		HX_STACK_VAR(tmp14,"tmp14");
						HX_STACK_LINE(167)
						bool tmp15 = (tmp14 == HX_HCSTRING("unique passive","\x98","\x17","\x9e","\x8a"));		HX_STACK_VAR(tmp15,"tmp15");
						HX_STACK_LINE(167)
						if ((tmp15)){
							HX_STACK_LINE(168)
							::String tmp16 = stone_property.split(HX_HCSTRING(":","\x3a","\x00","\x00","\x00"))->__get((int)0);		HX_STACK_VAR(tmp16,"tmp16");
							HX_STACK_LINE(168)
							::String key = tmp16;		HX_STACK_VAR(key,"key");
							HX_STACK_LINE(168)
							::String tmp17 = stone_property.split(HX_HCSTRING(":","\x3a","\x00","\x00","\x00"))->__get((int)1);		HX_STACK_VAR(tmp17,"tmp17");
							HX_STACK_LINE(168)
							::String value = tmp17;		HX_STACK_VAR(value,"value");
							HX_STACK_LINE(168)
							::String tmp18 = key;		HX_STACK_VAR(tmp18,"tmp18");
							HX_STACK_LINE(168)
							::String tmp19 = value;		HX_STACK_VAR(tmp19,"tmp19");
							HX_STACK_LINE(168)
							properties->set(tmp18,tmp19);
						}
						else{
							HX_STACK_LINE(170)
							::String tmp16 = stone_property.split(HX_HCSTRING(":","\x3a","\x00","\x00","\x00"))->__get((int)0);		HX_STACK_VAR(tmp16,"tmp16");
							HX_STACK_LINE(170)
							::String key = tmp16;		HX_STACK_VAR(key,"key");
							HX_STACK_LINE(170)
							::String tmp17;		HX_STACK_VAR(tmp17,"tmp17");
							HX_STACK_LINE(170)
							{
								HX_STACK_LINE(170)
								::String tmp18 = stone_property.split(HX_HCSTRING(":","\x3a","\x00","\x00","\x00"))->__get((int)0);		HX_STACK_VAR(tmp18,"tmp18");
								HX_STACK_LINE(170)
								::String key1 = tmp18;		HX_STACK_VAR(key1,"key1");
								HX_STACK_LINE(170)
								::String tmp19 = key1;		HX_STACK_VAR(tmp19,"tmp19");
								HX_STACK_LINE(170)
								tmp17 = properties->get(tmp19);
							}
							HX_STACK_LINE(170)
							Float tmp18 = ::Std_obj::parseFloat(tmp17);		HX_STACK_VAR(tmp18,"tmp18");
							HX_STACK_LINE(170)
							::String tmp19 = stone_property.split(HX_HCSTRING(":","\x3a","\x00","\x00","\x00"))->__get((int)1);		HX_STACK_VAR(tmp19,"tmp19");
							HX_STACK_LINE(170)
							Float tmp20 = ::Std_obj::parseFloat(tmp19);		HX_STACK_VAR(tmp20,"tmp20");
							HX_STACK_LINE(170)
							Float tmp21 = (tmp18 + tmp20);		HX_STACK_VAR(tmp21,"tmp21");
							HX_STACK_LINE(170)
							Float tmp22 = (tmp21 * (int)100);		HX_STACK_VAR(tmp22,"tmp22");
							HX_STACK_LINE(170)
							int tmp23 = ::Math_obj::round(tmp22);		HX_STACK_VAR(tmp23,"tmp23");
							HX_STACK_LINE(170)
							Float tmp24 = (Float(tmp23) / Float((int)100));		HX_STACK_VAR(tmp24,"tmp24");
							HX_STACK_LINE(170)
							::String tmp25 = (HX_HCSTRING("","\x00","\x00","\x00","\x00") + tmp24);		HX_STACK_VAR(tmp25,"tmp25");
							HX_STACK_LINE(170)
							::String value = tmp25;		HX_STACK_VAR(value,"value");
							HX_STACK_LINE(170)
							::String tmp26 = key;		HX_STACK_VAR(tmp26,"tmp26");
							HX_STACK_LINE(170)
							::String tmp27 = value;		HX_STACK_VAR(tmp27,"tmp27");
							HX_STACK_LINE(170)
							properties->set(tmp26,tmp27);
						}
					}
				}
			}
		}
		HX_STACK_LINE(174)
		Dynamic tmp2 = properties->keys();		HX_STACK_VAR(tmp2,"tmp2");
		HX_STACK_LINE(174)
		for(::cpp::FastIterator_obj< ::String > *__it = ::cpp::CreateFastIterator< ::String >(tmp2);  __it->hasNext(); ){
			::String property = __it->next();
			{
				HX_STACK_LINE(175)
				::flixel::text::FlxText tmp3 = this->stats_text;		HX_STACK_VAR(tmp3,"tmp3");
				HX_STACK_LINE(175)
				::flixel::text::FlxText _g = tmp3;		HX_STACK_VAR(_g,"_g");
				HX_STACK_LINE(175)
				::String tmp4 = _g->get_text();		HX_STACK_VAR(tmp4,"tmp4");
				HX_STACK_LINE(175)
				::String tmp5 = (HX_HCSTRING("    ","\x00","\x38","\x3f","\x15") + property);		HX_STACK_VAR(tmp5,"tmp5");
				HX_STACK_LINE(175)
				::String tmp6 = (tmp5 + HX_HCSTRING(": ","\xa6","\x32","\x00","\x00"));		HX_STACK_VAR(tmp6,"tmp6");
				HX_STACK_LINE(175)
				::String tmp7 = property;		HX_STACK_VAR(tmp7,"tmp7");
				HX_STACK_LINE(175)
				::String tmp8 = properties->get(tmp7);		HX_STACK_VAR(tmp8,"tmp8");
				HX_STACK_LINE(175)
				::String tmp9 = tmp8;		HX_STACK_VAR(tmp9,"tmp9");
				HX_STACK_LINE(175)
				::String tmp10 = (tmp6 + tmp9);		HX_STACK_VAR(tmp10,"tmp10");
				HX_STACK_LINE(175)
				::String tmp11 = (tmp10 + HX_HCSTRING("\n","\x0a","\x00","\x00","\x00"));		HX_STACK_VAR(tmp11,"tmp11");
				HX_STACK_LINE(175)
				::String tmp12 = (tmp4 + tmp11);		HX_STACK_VAR(tmp12,"tmp12");
				HX_STACK_LINE(175)
				_g->set_text(tmp12);
			}
;
		}
		HX_STACK_LINE(178)
		::flixel::FlxSprite tmp3 = this->mouse_collider_sprite;		HX_STACK_VAR(tmp3,"tmp3");
		HX_STACK_LINE(178)
		::flixel::input::mouse::FlxMouse tmp4 = ::flixel::FlxG_obj::mouse;		HX_STACK_VAR(tmp4,"tmp4");
		HX_STACK_LINE(178)
		::flixel::util::FlxPoint tmp5 = tmp4->getWorldPosition(null(),null());		HX_STACK_VAR(tmp5,"tmp5");
		HX_STACK_LINE(178)
		Float tmp6 = tmp5->x;		HX_STACK_VAR(tmp6,"tmp6");
		HX_STACK_LINE(178)
		tmp3->set_x(tmp6);
		HX_STACK_LINE(179)
		::flixel::FlxSprite tmp7 = this->mouse_collider_sprite;		HX_STACK_VAR(tmp7,"tmp7");
		HX_STACK_LINE(179)
		::flixel::input::mouse::FlxMouse tmp8 = ::flixel::FlxG_obj::mouse;		HX_STACK_VAR(tmp8,"tmp8");
		HX_STACK_LINE(179)
		::flixel::util::FlxPoint tmp9 = tmp8->getWorldPosition(null(),null());		HX_STACK_VAR(tmp9,"tmp9");
		HX_STACK_LINE(179)
		Float tmp10 = tmp9->y;		HX_STACK_VAR(tmp10,"tmp10");
		HX_STACK_LINE(179)
		tmp7->set_y(tmp10);
		HX_STACK_LINE(180)
		::flixel::FlxSprite tmp11 = this->mouse_collider_sprite;		HX_STACK_VAR(tmp11,"tmp11");
		HX_STACK_LINE(180)
		tmp11->updateHitbox();
		HX_STACK_LINE(182)
		bool mouseWasOverStone = false;		HX_STACK_VAR(mouseWasOverStone,"mouseWasOverStone");
		HX_STACK_LINE(183)
		{
			HX_STACK_LINE(183)
			::List tmp12 = this->draggableWaystones;		HX_STACK_VAR(tmp12,"tmp12");
			HX_STACK_LINE(183)
			::_List::ListIterator tmp13 = ::_List::ListIterator_obj::__new(tmp12->h);		HX_STACK_VAR(tmp13,"tmp13");
			HX_STACK_LINE(183)
			::_List::ListIterator _g = tmp13;		HX_STACK_VAR(_g,"_g");
			HX_STACK_LINE(183)
			while((true)){
				HX_STACK_LINE(183)
				bool tmp14 = (_g->head != null());		HX_STACK_VAR(tmp14,"tmp14");
				HX_STACK_LINE(183)
				bool tmp15 = !(tmp14);		HX_STACK_VAR(tmp15,"tmp15");
				HX_STACK_LINE(183)
				if ((tmp15)){
					HX_STACK_LINE(183)
					break;
				}
				HX_STACK_LINE(183)
				Dynamic tmp16;		HX_STACK_VAR(tmp16,"tmp16");
				HX_STACK_LINE(183)
				{
					HX_STACK_LINE(183)
					Dynamic tmp17 = _g->head->__GetItem((int)0);		HX_STACK_VAR(tmp17,"tmp17");
					HX_STACK_LINE(183)
					_g->val = tmp17;
					HX_STACK_LINE(183)
					Dynamic tmp18 = _g->head->__GetItem((int)1);		HX_STACK_VAR(tmp18,"tmp18");
					HX_STACK_LINE(183)
					_g->head = tmp18;
					HX_STACK_LINE(183)
					tmp16 = _g->val;
				}
				HX_STACK_LINE(183)
				::DraggableWaystone waystone = ((::DraggableWaystone)(tmp16));		HX_STACK_VAR(waystone,"waystone");
				HX_STACK_LINE(184)
				::DraggableWaystone tmp17;		HX_STACK_VAR(tmp17,"tmp17");
				HX_STACK_LINE(184)
				tmp17 = hx::TCast< ::DraggableWaystone >::cast(waystone);
				HX_STACK_LINE(184)
				::DraggableWaystone stone = tmp17;		HX_STACK_VAR(stone,"stone");
				HX_STACK_LINE(185)
				::flixel::FlxSprite tmp18 = this->mouse_collider_sprite;		HX_STACK_VAR(tmp18,"tmp18");
				HX_STACK_LINE(185)
				Float tmp19 = tmp18->y;		HX_STACK_VAR(tmp19,"tmp19");
				HX_STACK_LINE(185)
				bool tmp20 = (tmp19 > (int)100);		HX_STACK_VAR(tmp20,"tmp20");
				HX_STACK_LINE(185)
				bool tmp21 = tmp20;		HX_STACK_VAR(tmp21,"tmp21");
				HX_STACK_LINE(185)
				bool tmp22;		HX_STACK_VAR(tmp22,"tmp22");
				HX_STACK_LINE(185)
				if ((tmp21)){
					HX_STACK_LINE(185)
					::flixel::FlxSprite tmp23 = this->mouse_collider_sprite;		HX_STACK_VAR(tmp23,"tmp23");
					HX_STACK_LINE(185)
					::flixel::FlxSprite tmp24 = tmp23;		HX_STACK_VAR(tmp24,"tmp24");
					HX_STACK_LINE(185)
					::flixel::FlxSprite tmp25 = tmp24;		HX_STACK_VAR(tmp25,"tmp25");
					HX_STACK_LINE(185)
					Float tmp26 = tmp25->x;		HX_STACK_VAR(tmp26,"tmp26");
					HX_STACK_LINE(185)
					Float tmp27 = (stone->x + (int)100);		HX_STACK_VAR(tmp27,"tmp27");
					HX_STACK_LINE(185)
					Float tmp28 = tmp27;		HX_STACK_VAR(tmp28,"tmp28");
					HX_STACK_LINE(185)
					Float tmp29 = tmp28;		HX_STACK_VAR(tmp29,"tmp29");
					HX_STACK_LINE(185)
					tmp22 = (tmp26 < tmp29);
				}
				else{
					HX_STACK_LINE(185)
					tmp22 = false;
				}
				HX_STACK_LINE(185)
				bool tmp23 = tmp22;		HX_STACK_VAR(tmp23,"tmp23");
				HX_STACK_LINE(185)
				bool tmp24;		HX_STACK_VAR(tmp24,"tmp24");
				HX_STACK_LINE(185)
				if ((tmp23)){
					HX_STACK_LINE(185)
					::flixel::FlxSprite tmp25 = this->mouse_collider_sprite;		HX_STACK_VAR(tmp25,"tmp25");
					HX_STACK_LINE(185)
					::flixel::FlxSprite tmp26 = tmp25;		HX_STACK_VAR(tmp26,"tmp26");
					HX_STACK_LINE(185)
					::flixel::FlxSprite tmp27 = tmp26;		HX_STACK_VAR(tmp27,"tmp27");
					HX_STACK_LINE(185)
					Float tmp28 = tmp27->y;		HX_STACK_VAR(tmp28,"tmp28");
					HX_STACK_LINE(185)
					Float tmp29 = (stone->y + (int)100);		HX_STACK_VAR(tmp29,"tmp29");
					HX_STACK_LINE(185)
					Float tmp30 = tmp29;		HX_STACK_VAR(tmp30,"tmp30");
					HX_STACK_LINE(185)
					Float tmp31 = tmp30;		HX_STACK_VAR(tmp31,"tmp31");
					HX_STACK_LINE(185)
					tmp24 = (tmp28 < tmp31);
				}
				else{
					HX_STACK_LINE(185)
					tmp24 = false;
				}
				HX_STACK_LINE(185)
				bool tmp25 = tmp24;		HX_STACK_VAR(tmp25,"tmp25");
				HX_STACK_LINE(185)
				bool tmp26;		HX_STACK_VAR(tmp26,"tmp26");
				HX_STACK_LINE(185)
				if ((tmp25)){
					HX_STACK_LINE(185)
					::flixel::FlxSprite tmp27 = this->mouse_collider_sprite;		HX_STACK_VAR(tmp27,"tmp27");
					HX_STACK_LINE(185)
					::flixel::FlxSprite tmp28 = tmp27;		HX_STACK_VAR(tmp28,"tmp28");
					HX_STACK_LINE(185)
					::flixel::FlxSprite tmp29 = tmp28;		HX_STACK_VAR(tmp29,"tmp29");
					HX_STACK_LINE(185)
					Float tmp30 = tmp29->x;		HX_STACK_VAR(tmp30,"tmp30");
					HX_STACK_LINE(185)
					Float tmp31 = stone->x;		HX_STACK_VAR(tmp31,"tmp31");
					HX_STACK_LINE(185)
					tmp26 = (tmp30 > tmp31);
				}
				else{
					HX_STACK_LINE(185)
					tmp26 = false;
				}
				HX_STACK_LINE(185)
				bool tmp27;		HX_STACK_VAR(tmp27,"tmp27");
				HX_STACK_LINE(185)
				if ((tmp26)){
					HX_STACK_LINE(185)
					::flixel::FlxSprite tmp28 = this->mouse_collider_sprite;		HX_STACK_VAR(tmp28,"tmp28");
					HX_STACK_LINE(185)
					::flixel::FlxSprite tmp29 = tmp28;		HX_STACK_VAR(tmp29,"tmp29");
					HX_STACK_LINE(185)
					Float tmp30 = tmp29->y;		HX_STACK_VAR(tmp30,"tmp30");
					HX_STACK_LINE(185)
					Float tmp31 = stone->y;		HX_STACK_VAR(tmp31,"tmp31");
					HX_STACK_LINE(185)
					tmp27 = (tmp30 > tmp31);
				}
				else{
					HX_STACK_LINE(185)
					tmp27 = false;
				}
				HX_STACK_LINE(185)
				if ((tmp27)){
					HX_STACK_LINE(186)
					int tmp28 = this->tooltipAppearTimer;		HX_STACK_VAR(tmp28,"tmp28");
					HX_STACK_LINE(186)
					bool tmp29 = (tmp28 < (int)30);		HX_STACK_VAR(tmp29,"tmp29");
					HX_STACK_LINE(186)
					if ((tmp29)){
						HX_STACK_LINE(187)
						(this->tooltipAppearTimer)++;
					}
					else{
						HX_STACK_LINE(189)
						::flixel::group::FlxGroup tmp30 = this->tooltip_group;		HX_STACK_VAR(tmp30,"tmp30");
						HX_STACK_LINE(189)
						bool tmp31 = (tmp30 != null());		HX_STACK_VAR(tmp31,"tmp31");
						HX_STACK_LINE(189)
						if ((tmp31)){
							HX_STACK_LINE(190)
							::flixel::group::FlxGroup tmp32 = this->tooltip_group;		HX_STACK_VAR(tmp32,"tmp32");
							HX_STACK_LINE(190)
							this->remove(tmp32,null());
						}
						HX_STACK_LINE(192)
						::flixel::group::FlxGroup tmp32 = ::flixel::group::FlxGroup_obj::__new(null());		HX_STACK_VAR(tmp32,"tmp32");
						HX_STACK_LINE(192)
						this->tooltip_group = tmp32;
						HX_STACK_LINE(193)
						::flixel::group::FlxGroup tmp33 = this->tooltip_group;		HX_STACK_VAR(tmp33,"tmp33");
						HX_STACK_LINE(193)
						this->add(tmp33);
						HX_STACK_LINE(195)
						Float tmp34 = (stone->x + (int)100);		HX_STACK_VAR(tmp34,"tmp34");
						HX_STACK_LINE(195)
						Float tmp35 = stone->y;		HX_STACK_VAR(tmp35,"tmp35");
						HX_STACK_LINE(195)
						::flixel::FlxSprite tmp36 = ::flixel::FlxSprite_obj::__new(tmp34,tmp35,null());		HX_STACK_VAR(tmp36,"tmp36");
						HX_STACK_LINE(195)
						::flixel::FlxSprite tooltipBackground = tmp36;		HX_STACK_VAR(tooltipBackground,"tooltipBackground");
						HX_STACK_LINE(196)
						tooltipBackground->loadGraphic(HX_HCSTRING("assets/images/tooltip.png","\xf3","\x69","\x32","\x7c"),null(),null(),null(),null(),null());
						HX_STACK_LINE(197)
						::flixel::group::FlxGroup tmp37 = this->tooltip_group;		HX_STACK_VAR(tmp37,"tmp37");
						HX_STACK_LINE(197)
						::flixel::FlxSprite tmp38 = tooltipBackground;		HX_STACK_VAR(tmp38,"tmp38");
						HX_STACK_LINE(197)
						tmp37->add(tmp38);
						HX_STACK_LINE(199)
						Float tmp39 = (stone->x + (int)100);		HX_STACK_VAR(tmp39,"tmp39");
						HX_STACK_LINE(199)
						Float tmp40 = (tmp39 + (int)5);		HX_STACK_VAR(tmp40,"tmp40");
						HX_STACK_LINE(199)
						Float tmp41 = stone->y;		HX_STACK_VAR(tmp41,"tmp41");
						HX_STACK_LINE(199)
						::String tmp42 = stone->name;		HX_STACK_VAR(tmp42,"tmp42");
						HX_STACK_LINE(199)
						::flixel::text::FlxText tmp43 = ::flixel::text::FlxText_obj::__new(tmp40,tmp41,(int)230,tmp42,(int)13,null());		HX_STACK_VAR(tmp43,"tmp43");
						HX_STACK_LINE(199)
						::flixel::text::FlxText titleText = tmp43;		HX_STACK_VAR(titleText,"titleText");
						HX_STACK_LINE(200)
						titleText->set_color((int)0);
						HX_STACK_LINE(202)
						Float tmp44 = (stone->x + (int)100);		HX_STACK_VAR(tmp44,"tmp44");
						HX_STACK_LINE(202)
						Float tmp45 = (tmp44 + (int)25);		HX_STACK_VAR(tmp45,"tmp45");
						HX_STACK_LINE(202)
						Float tmp46 = (stone->y + (int)22);		HX_STACK_VAR(tmp46,"tmp46");
						HX_STACK_LINE(202)
						::flixel::text::FlxText tmp47 = ::flixel::text::FlxText_obj::__new(tmp45,tmp46,(int)230,HX_HCSTRING("","\x00","\x00","\x00","\x00"),(int)11,null());		HX_STACK_VAR(tmp47,"tmp47");
						HX_STACK_LINE(202)
						::flixel::text::FlxText bodyText = tmp47;		HX_STACK_VAR(bodyText,"bodyText");
						HX_STACK_LINE(203)
						bodyText->set_color((int)1118481);
						HX_STACK_LINE(204)
						{
							HX_STACK_LINE(204)
							int _g1 = (int)0;		HX_STACK_VAR(_g1,"_g1");
							HX_STACK_LINE(204)
							Array< ::String > _g11 = stone->stone_properties;		HX_STACK_VAR(_g11,"_g11");
							HX_STACK_LINE(204)
							while((true)){
								HX_STACK_LINE(204)
								bool tmp48 = (_g1 < _g11->length);		HX_STACK_VAR(tmp48,"tmp48");
								HX_STACK_LINE(204)
								bool tmp49 = !(tmp48);		HX_STACK_VAR(tmp49,"tmp49");
								HX_STACK_LINE(204)
								if ((tmp49)){
									HX_STACK_LINE(204)
									break;
								}
								HX_STACK_LINE(204)
								::String tmp50 = _g11->__get(_g1);		HX_STACK_VAR(tmp50,"tmp50");
								HX_STACK_LINE(204)
								::String prop = tmp50;		HX_STACK_VAR(prop,"prop");
								HX_STACK_LINE(204)
								++(_g1);
								HX_STACK_LINE(205)
								{
									HX_STACK_LINE(205)
									::flixel::text::FlxText _g2 = bodyText;		HX_STACK_VAR(_g2,"_g2");
									HX_STACK_LINE(205)
									::String tmp51 = _g2->get_text();		HX_STACK_VAR(tmp51,"tmp51");
									HX_STACK_LINE(205)
									::String tmp52 = (prop + HX_HCSTRING("\n","\x0a","\x00","\x00","\x00"));		HX_STACK_VAR(tmp52,"tmp52");
									HX_STACK_LINE(205)
									::String tmp53 = (tmp51 + tmp52);		HX_STACK_VAR(tmp53,"tmp53");
									HX_STACK_LINE(205)
									_g2->set_text(tmp53);
								}
							}
						}
						HX_STACK_LINE(208)
						::flixel::group::FlxGroup tmp48 = this->tooltip_group;		HX_STACK_VAR(tmp48,"tmp48");
						HX_STACK_LINE(208)
						::flixel::text::FlxText tmp49 = titleText;		HX_STACK_VAR(tmp49,"tmp49");
						HX_STACK_LINE(208)
						tmp48->add(tmp49);
						HX_STACK_LINE(209)
						::flixel::group::FlxGroup tmp50 = this->tooltip_group;		HX_STACK_VAR(tmp50,"tmp50");
						HX_STACK_LINE(209)
						::flixel::text::FlxText tmp51 = bodyText;		HX_STACK_VAR(tmp51,"tmp51");
						HX_STACK_LINE(209)
						tmp50->add(tmp51);
					}
					HX_STACK_LINE(211)
					mouseWasOverStone = true;
				}
			}
		}
		HX_STACK_LINE(214)
		bool tmp12 = mouseWasOverStone;		HX_STACK_VAR(tmp12,"tmp12");
		HX_STACK_LINE(214)
		bool tmp13 = !(tmp12);		HX_STACK_VAR(tmp13,"tmp13");
		HX_STACK_LINE(214)
		if ((tmp13)){
			HX_STACK_LINE(215)
			this->tooltipAppearTimer = (int)0;
			HX_STACK_LINE(216)
			::flixel::group::FlxGroup tmp14 = this->tooltip_group;		HX_STACK_VAR(tmp14,"tmp14");
			HX_STACK_LINE(216)
			bool tmp15 = (tmp14 != null());		HX_STACK_VAR(tmp15,"tmp15");
			HX_STACK_LINE(216)
			if ((tmp15)){
				HX_STACK_LINE(217)
				::flixel::group::FlxGroup tmp16 = this->tooltip_group;		HX_STACK_VAR(tmp16,"tmp16");
				HX_STACK_LINE(217)
				this->remove(tmp16,null());
				HX_STACK_LINE(218)
				this->tooltip_group = null();
			}
		}
		HX_STACK_LINE(222)
		bool tmp14;		HX_STACK_VAR(tmp14,"tmp14");
		HX_STACK_LINE(222)
		{
			HX_STACK_LINE(222)
			::flixel::input::mouse::FlxMouse tmp15 = ::flixel::FlxG_obj::mouse;		HX_STACK_VAR(tmp15,"tmp15");
			HX_STACK_LINE(222)
			::flixel::input::mouse::FlxMouseButton _this = tmp15->_leftButton;		HX_STACK_VAR(_this,"_this");
			HX_STACK_LINE(222)
			bool tmp16 = (_this->current == (int)2);		HX_STACK_VAR(tmp16,"tmp16");
			HX_STACK_LINE(222)
			bool tmp17 = !(tmp16);		HX_STACK_VAR(tmp17,"tmp17");
			HX_STACK_LINE(222)
			if ((tmp17)){
				HX_STACK_LINE(222)
				tmp14 = (_this->current == (int)-2);
			}
			else{
				HX_STACK_LINE(222)
				tmp14 = true;
			}
		}
		HX_STACK_LINE(222)
		if ((tmp14)){
			HX_STACK_LINE(223)
			::flixel::FlxSprite tmp15 = this->mouse_collider_sprite;		HX_STACK_VAR(tmp15,"tmp15");
			HX_STACK_LINE(223)
			::flixel::FlxSprite tmp16 = this->scrollbar_sprite;		HX_STACK_VAR(tmp16,"tmp16");
			HX_STACK_LINE(223)
			bool tmp17 = ::flixel::util::FlxCollision_obj::pixelPerfectCheck(tmp15,tmp16,null(),null());		HX_STACK_VAR(tmp17,"tmp17");
			HX_STACK_LINE(223)
			if ((tmp17)){
				HX_STACK_LINE(224)
				::flixel::FlxSprite tmp18 = this->scrollbar_sprite;		HX_STACK_VAR(tmp18,"tmp18");
				HX_STACK_LINE(224)
				this->sprite_following_mouse = tmp18;
			}
			HX_STACK_LINE(226)
			{
				HX_STACK_LINE(226)
				::List tmp18 = this->draggableWaystones;		HX_STACK_VAR(tmp18,"tmp18");
				HX_STACK_LINE(226)
				::_List::ListIterator tmp19 = ::_List::ListIterator_obj::__new(tmp18->h);		HX_STACK_VAR(tmp19,"tmp19");
				HX_STACK_LINE(226)
				::_List::ListIterator _g = tmp19;		HX_STACK_VAR(_g,"_g");
				HX_STACK_LINE(226)
				while((true)){
					HX_STACK_LINE(226)
					bool tmp20 = (_g->head != null());		HX_STACK_VAR(tmp20,"tmp20");
					HX_STACK_LINE(226)
					bool tmp21 = !(tmp20);		HX_STACK_VAR(tmp21,"tmp21");
					HX_STACK_LINE(226)
					if ((tmp21)){
						HX_STACK_LINE(226)
						break;
					}
					HX_STACK_LINE(226)
					Dynamic tmp22;		HX_STACK_VAR(tmp22,"tmp22");
					HX_STACK_LINE(226)
					{
						HX_STACK_LINE(226)
						Dynamic tmp23 = _g->head->__GetItem((int)0);		HX_STACK_VAR(tmp23,"tmp23");
						HX_STACK_LINE(226)
						_g->val = tmp23;
						HX_STACK_LINE(226)
						Dynamic tmp24 = _g->head->__GetItem((int)1);		HX_STACK_VAR(tmp24,"tmp24");
						HX_STACK_LINE(226)
						_g->head = tmp24;
						HX_STACK_LINE(226)
						tmp22 = _g->val;
					}
					HX_STACK_LINE(226)
					::DraggableWaystone waystone = ((::DraggableWaystone)(tmp22));		HX_STACK_VAR(waystone,"waystone");
					HX_STACK_LINE(227)
					::DraggableWaystone tmp23;		HX_STACK_VAR(tmp23,"tmp23");
					HX_STACK_LINE(227)
					tmp23 = hx::TCast< ::DraggableWaystone >::cast(waystone);
					HX_STACK_LINE(227)
					::DraggableWaystone stone = tmp23;		HX_STACK_VAR(stone,"stone");
					HX_STACK_LINE(228)
					stone->updateHitbox();
					HX_STACK_LINE(229)
					::flixel::FlxSprite tmp24 = this->mouse_collider_sprite;		HX_STACK_VAR(tmp24,"tmp24");
					HX_STACK_LINE(229)
					Float tmp25 = tmp24->y;		HX_STACK_VAR(tmp25,"tmp25");
					HX_STACK_LINE(229)
					bool tmp26 = (tmp25 > (int)100);		HX_STACK_VAR(tmp26,"tmp26");
					HX_STACK_LINE(229)
					bool tmp27 = tmp26;		HX_STACK_VAR(tmp27,"tmp27");
					HX_STACK_LINE(229)
					bool tmp28;		HX_STACK_VAR(tmp28,"tmp28");
					HX_STACK_LINE(229)
					if ((tmp27)){
						HX_STACK_LINE(229)
						::flixel::FlxSprite tmp29 = this->mouse_collider_sprite;		HX_STACK_VAR(tmp29,"tmp29");
						HX_STACK_LINE(229)
						::flixel::FlxSprite tmp30 = tmp29;		HX_STACK_VAR(tmp30,"tmp30");
						HX_STACK_LINE(229)
						::flixel::FlxSprite tmp31 = tmp30;		HX_STACK_VAR(tmp31,"tmp31");
						HX_STACK_LINE(229)
						Float tmp32 = tmp31->x;		HX_STACK_VAR(tmp32,"tmp32");
						HX_STACK_LINE(229)
						Float tmp33 = (stone->x + (int)100);		HX_STACK_VAR(tmp33,"tmp33");
						HX_STACK_LINE(229)
						Float tmp34 = tmp33;		HX_STACK_VAR(tmp34,"tmp34");
						HX_STACK_LINE(229)
						Float tmp35 = tmp34;		HX_STACK_VAR(tmp35,"tmp35");
						HX_STACK_LINE(229)
						tmp28 = (tmp32 < tmp35);
					}
					else{
						HX_STACK_LINE(229)
						tmp28 = false;
					}
					HX_STACK_LINE(229)
					bool tmp29 = tmp28;		HX_STACK_VAR(tmp29,"tmp29");
					HX_STACK_LINE(229)
					bool tmp30;		HX_STACK_VAR(tmp30,"tmp30");
					HX_STACK_LINE(229)
					if ((tmp29)){
						HX_STACK_LINE(229)
						::flixel::FlxSprite tmp31 = this->mouse_collider_sprite;		HX_STACK_VAR(tmp31,"tmp31");
						HX_STACK_LINE(229)
						::flixel::FlxSprite tmp32 = tmp31;		HX_STACK_VAR(tmp32,"tmp32");
						HX_STACK_LINE(229)
						::flixel::FlxSprite tmp33 = tmp32;		HX_STACK_VAR(tmp33,"tmp33");
						HX_STACK_LINE(229)
						Float tmp34 = tmp33->y;		HX_STACK_VAR(tmp34,"tmp34");
						HX_STACK_LINE(229)
						Float tmp35 = (stone->y + (int)100);		HX_STACK_VAR(tmp35,"tmp35");
						HX_STACK_LINE(229)
						Float tmp36 = tmp35;		HX_STACK_VAR(tmp36,"tmp36");
						HX_STACK_LINE(229)
						Float tmp37 = tmp36;		HX_STACK_VAR(tmp37,"tmp37");
						HX_STACK_LINE(229)
						tmp30 = (tmp34 < tmp37);
					}
					else{
						HX_STACK_LINE(229)
						tmp30 = false;
					}
					HX_STACK_LINE(229)
					bool tmp31 = tmp30;		HX_STACK_VAR(tmp31,"tmp31");
					HX_STACK_LINE(229)
					bool tmp32;		HX_STACK_VAR(tmp32,"tmp32");
					HX_STACK_LINE(229)
					if ((tmp31)){
						HX_STACK_LINE(229)
						::flixel::FlxSprite tmp33 = this->mouse_collider_sprite;		HX_STACK_VAR(tmp33,"tmp33");
						HX_STACK_LINE(229)
						::flixel::FlxSprite tmp34 = tmp33;		HX_STACK_VAR(tmp34,"tmp34");
						HX_STACK_LINE(229)
						::flixel::FlxSprite tmp35 = tmp34;		HX_STACK_VAR(tmp35,"tmp35");
						HX_STACK_LINE(229)
						Float tmp36 = tmp35->x;		HX_STACK_VAR(tmp36,"tmp36");
						HX_STACK_LINE(229)
						Float tmp37 = stone->x;		HX_STACK_VAR(tmp37,"tmp37");
						HX_STACK_LINE(229)
						tmp32 = (tmp36 > tmp37);
					}
					else{
						HX_STACK_LINE(229)
						tmp32 = false;
					}
					HX_STACK_LINE(229)
					bool tmp33;		HX_STACK_VAR(tmp33,"tmp33");
					HX_STACK_LINE(229)
					if ((tmp32)){
						HX_STACK_LINE(229)
						::flixel::FlxSprite tmp34 = this->mouse_collider_sprite;		HX_STACK_VAR(tmp34,"tmp34");
						HX_STACK_LINE(229)
						::flixel::FlxSprite tmp35 = tmp34;		HX_STACK_VAR(tmp35,"tmp35");
						HX_STACK_LINE(229)
						Float tmp36 = tmp35->y;		HX_STACK_VAR(tmp36,"tmp36");
						HX_STACK_LINE(229)
						Float tmp37 = stone->y;		HX_STACK_VAR(tmp37,"tmp37");
						HX_STACK_LINE(229)
						tmp33 = (tmp36 > tmp37);
					}
					else{
						HX_STACK_LINE(229)
						tmp33 = false;
					}
					HX_STACK_LINE(229)
					if ((tmp33)){
						HX_STACK_LINE(230)
						::DraggableWaystone tmp34 = stone;		HX_STACK_VAR(tmp34,"tmp34");
						HX_STACK_LINE(230)
						stone->onMouseDown(tmp34);
					}
				}
			}
			HX_STACK_LINE(233)
			{
				HX_STACK_LINE(233)
				::List tmp18 = this->waystones;		HX_STACK_VAR(tmp18,"tmp18");
				HX_STACK_LINE(233)
				::_List::ListIterator tmp19 = ::_List::ListIterator_obj::__new(tmp18->h);		HX_STACK_VAR(tmp19,"tmp19");
				HX_STACK_LINE(233)
				::_List::ListIterator _g = tmp19;		HX_STACK_VAR(_g,"_g");
				HX_STACK_LINE(233)
				while((true)){
					HX_STACK_LINE(233)
					bool tmp20 = (_g->head != null());		HX_STACK_VAR(tmp20,"tmp20");
					HX_STACK_LINE(233)
					bool tmp21 = !(tmp20);		HX_STACK_VAR(tmp21,"tmp21");
					HX_STACK_LINE(233)
					if ((tmp21)){
						HX_STACK_LINE(233)
						break;
					}
					HX_STACK_LINE(233)
					Dynamic tmp22;		HX_STACK_VAR(tmp22,"tmp22");
					HX_STACK_LINE(233)
					{
						HX_STACK_LINE(233)
						Dynamic tmp23 = _g->head->__GetItem((int)0);		HX_STACK_VAR(tmp23,"tmp23");
						HX_STACK_LINE(233)
						_g->val = tmp23;
						HX_STACK_LINE(233)
						Dynamic tmp24 = _g->head->__GetItem((int)1);		HX_STACK_VAR(tmp24,"tmp24");
						HX_STACK_LINE(233)
						_g->head = tmp24;
						HX_STACK_LINE(233)
						tmp22 = _g->val;
					}
					HX_STACK_LINE(233)
					::PlacedWaystone waystone = ((::PlacedWaystone)(tmp22));		HX_STACK_VAR(waystone,"waystone");
					HX_STACK_LINE(234)
					::PlacedWaystone tmp23;		HX_STACK_VAR(tmp23,"tmp23");
					HX_STACK_LINE(234)
					tmp23 = hx::TCast< ::PlacedWaystone >::cast(waystone);
					HX_STACK_LINE(234)
					::PlacedWaystone stone = tmp23;		HX_STACK_VAR(stone,"stone");
					HX_STACK_LINE(235)
					stone->updateHitbox();
					HX_STACK_LINE(236)
					::flixel::FlxSprite tmp24 = this->mouse_collider_sprite;		HX_STACK_VAR(tmp24,"tmp24");
					HX_STACK_LINE(236)
					::PlacedWaystone tmp25 = stone;		HX_STACK_VAR(tmp25,"tmp25");
					HX_STACK_LINE(236)
					bool tmp26 = ::flixel::util::FlxCollision_obj::pixelPerfectCheck(tmp24,tmp25,null(),null());		HX_STACK_VAR(tmp26,"tmp26");
					HX_STACK_LINE(236)
					if ((tmp26)){
						HX_STACK_LINE(237)
						::PlacedWaystone tmp27 = stone;		HX_STACK_VAR(tmp27,"tmp27");
						HX_STACK_LINE(237)
						stone->onMouseDown(tmp27);
					}
				}
			}
		}
		HX_STACK_LINE(241)
		bool tmp15;		HX_STACK_VAR(tmp15,"tmp15");
		HX_STACK_LINE(241)
		{
			HX_STACK_LINE(241)
			::flixel::input::mouse::FlxMouse tmp16 = ::flixel::FlxG_obj::mouse;		HX_STACK_VAR(tmp16,"tmp16");
			HX_STACK_LINE(241)
			::flixel::input::mouse::FlxMouseButton _this = tmp16->_leftButton;		HX_STACK_VAR(_this,"_this");
			HX_STACK_LINE(241)
			bool tmp17 = (_this->current == (int)-1);		HX_STACK_VAR(tmp17,"tmp17");
			HX_STACK_LINE(241)
			bool tmp18 = !(tmp17);		HX_STACK_VAR(tmp18,"tmp18");
			HX_STACK_LINE(241)
			if ((tmp18)){
				HX_STACK_LINE(241)
				tmp15 = (_this->current == (int)-2);
			}
			else{
				HX_STACK_LINE(241)
				tmp15 = true;
			}
		}
		HX_STACK_LINE(241)
		if ((tmp15)){
			HX_STACK_LINE(242)
			::flixel::FlxSprite tmp16 = this->sprite_following_mouse;		HX_STACK_VAR(tmp16,"tmp16");
			HX_STACK_LINE(242)
			::flixel::FlxSprite tmp17 = this->scrollbar_sprite;		HX_STACK_VAR(tmp17,"tmp17");
			HX_STACK_LINE(242)
			bool tmp18 = (tmp16 == tmp17);		HX_STACK_VAR(tmp18,"tmp18");
			HX_STACK_LINE(242)
			if ((tmp18)){
				HX_STACK_LINE(243)
				this->sprite_following_mouse = null();
			}
			HX_STACK_LINE(245)
			::flixel::FlxSprite tmp19 = this->sprite_following_mouse;		HX_STACK_VAR(tmp19,"tmp19");
			HX_STACK_LINE(245)
			bool tmp20 = ::Std_obj::is(tmp19,hx::ClassOf< ::DraggableWaystone >());		HX_STACK_VAR(tmp20,"tmp20");
			HX_STACK_LINE(245)
			if ((tmp20)){
				HX_STACK_LINE(246)
				::flixel::FlxSprite tmp21 = this->sprite_following_mouse;		HX_STACK_VAR(tmp21,"tmp21");
				HX_STACK_LINE(246)
				::DraggableWaystone tmp22;		HX_STACK_VAR(tmp22,"tmp22");
				HX_STACK_LINE(246)
				tmp22 = hx::TCast< ::DraggableWaystone >::cast(tmp21);
				HX_STACK_LINE(246)
				::flixel::FlxSprite tmp23 = this->sprite_following_mouse;		HX_STACK_VAR(tmp23,"tmp23");
				HX_STACK_LINE(246)
				tmp22->onMouseUp(tmp23);
			}
			HX_STACK_LINE(248)
			::flixel::FlxSprite tmp21 = this->sprite_following_mouse;		HX_STACK_VAR(tmp21,"tmp21");
			HX_STACK_LINE(248)
			bool tmp22 = ::Std_obj::is(tmp21,hx::ClassOf< ::PlacedWaystone >());		HX_STACK_VAR(tmp22,"tmp22");
			HX_STACK_LINE(248)
			if ((tmp22)){
				HX_STACK_LINE(249)
				::flixel::FlxSprite tmp23 = this->sprite_following_mouse;		HX_STACK_VAR(tmp23,"tmp23");
				HX_STACK_LINE(249)
				::PlacedWaystone tmp24;		HX_STACK_VAR(tmp24,"tmp24");
				HX_STACK_LINE(249)
				tmp24 = hx::TCast< ::PlacedWaystone >::cast(tmp23);
				HX_STACK_LINE(249)
				::flixel::FlxSprite tmp25 = this->sprite_following_mouse;		HX_STACK_VAR(tmp25,"tmp25");
				HX_STACK_LINE(249)
				::PlacedWaystone tmp26;		HX_STACK_VAR(tmp26,"tmp26");
				HX_STACK_LINE(249)
				tmp26 = hx::TCast< ::PlacedWaystone >::cast(tmp25);
				HX_STACK_LINE(249)
				tmp24->onMouseUp(tmp26);
			}
		}
		HX_STACK_LINE(252)
		bool tmp16;		HX_STACK_VAR(tmp16,"tmp16");
		HX_STACK_LINE(252)
		{
			HX_STACK_LINE(252)
			::flixel::input::mouse::FlxMouse tmp17 = ::flixel::FlxG_obj::mouse;		HX_STACK_VAR(tmp17,"tmp17");
			HX_STACK_LINE(252)
			::flixel::input::mouse::FlxMouseButton _this = tmp17->_rightButton;		HX_STACK_VAR(_this,"_this");
			HX_STACK_LINE(252)
			bool tmp18 = (_this->current == (int)2);		HX_STACK_VAR(tmp18,"tmp18");
			HX_STACK_LINE(252)
			bool tmp19 = !(tmp18);		HX_STACK_VAR(tmp19,"tmp19");
			HX_STACK_LINE(252)
			if ((tmp19)){
				HX_STACK_LINE(252)
				tmp16 = (_this->current == (int)-2);
			}
			else{
				HX_STACK_LINE(252)
				tmp16 = true;
			}
		}
		HX_STACK_LINE(252)
		if ((tmp16)){
			HX_STACK_LINE(253)
			::flixel::FlxSprite tmp17 = this->sprite_following_mouse;		HX_STACK_VAR(tmp17,"tmp17");
			HX_STACK_LINE(253)
			bool tmp18 = ::Std_obj::is(tmp17,hx::ClassOf< ::DraggableWaystone >());		HX_STACK_VAR(tmp18,"tmp18");
			HX_STACK_LINE(253)
			if ((tmp18)){
				HX_STACK_LINE(254)
				::flixel::FlxSprite tmp19 = this->sprite_following_mouse;		HX_STACK_VAR(tmp19,"tmp19");
				HX_STACK_LINE(254)
				::DraggableWaystone tmp20;		HX_STACK_VAR(tmp20,"tmp20");
				HX_STACK_LINE(254)
				tmp20 = hx::TCast< ::DraggableWaystone >::cast(tmp19);
				HX_STACK_LINE(254)
				::DraggableWaystone stone = tmp20;		HX_STACK_VAR(stone,"stone");
				HX_STACK_LINE(255)
				Float tmp21 = (stone->angle + (int)90);		HX_STACK_VAR(tmp21,"tmp21");
				HX_STACK_LINE(255)
				stone->set_angle(tmp21);
				HX_STACK_LINE(256)
				stone->updateHitbox();
			}
			HX_STACK_LINE(258)
			::flixel::FlxSprite tmp19 = this->sprite_following_mouse;		HX_STACK_VAR(tmp19,"tmp19");
			HX_STACK_LINE(258)
			bool tmp20 = ::Std_obj::is(tmp19,hx::ClassOf< ::PlacedWaystone >());		HX_STACK_VAR(tmp20,"tmp20");
			HX_STACK_LINE(258)
			if ((tmp20)){
				HX_STACK_LINE(259)
				::flixel::FlxSprite tmp21 = this->sprite_following_mouse;		HX_STACK_VAR(tmp21,"tmp21");
				HX_STACK_LINE(259)
				::PlacedWaystone tmp22;		HX_STACK_VAR(tmp22,"tmp22");
				HX_STACK_LINE(259)
				tmp22 = hx::TCast< ::PlacedWaystone >::cast(tmp21);
				HX_STACK_LINE(259)
				::PlacedWaystone stone = tmp22;		HX_STACK_VAR(stone,"stone");
				HX_STACK_LINE(260)
				Float tmp23 = (stone->angle + (int)90);		HX_STACK_VAR(tmp23,"tmp23");
				HX_STACK_LINE(260)
				stone->set_angle(tmp23);
				HX_STACK_LINE(261)
				stone->updateHitbox();
			}
		}
		HX_STACK_LINE(265)
		::flixel::FlxSprite tmp17 = this->sprite_following_mouse;		HX_STACK_VAR(tmp17,"tmp17");
		HX_STACK_LINE(265)
		bool tmp18 = (tmp17 != null());		HX_STACK_VAR(tmp18,"tmp18");
		HX_STACK_LINE(265)
		if ((tmp18)){
			HX_STACK_LINE(266)
			::flixel::FlxSprite tmp19 = this->sprite_following_mouse;		HX_STACK_VAR(tmp19,"tmp19");
			HX_STACK_LINE(266)
			Float lastPosX = tmp19->x;		HX_STACK_VAR(lastPosX,"lastPosX");
			HX_STACK_LINE(267)
			::flixel::FlxSprite tmp20 = this->sprite_following_mouse;		HX_STACK_VAR(tmp20,"tmp20");
			HX_STACK_LINE(267)
			Float lastPosY = tmp20->y;		HX_STACK_VAR(lastPosY,"lastPosY");
			HX_STACK_LINE(268)
			::flixel::FlxSprite tmp21 = this->sprite_following_mouse;		HX_STACK_VAR(tmp21,"tmp21");
			HX_STACK_LINE(268)
			::flixel::input::mouse::FlxMouse tmp22 = ::flixel::FlxG_obj::mouse;		HX_STACK_VAR(tmp22,"tmp22");
			HX_STACK_LINE(268)
			Float tmp23 = tmp22->x;		HX_STACK_VAR(tmp23,"tmp23");
			HX_STACK_LINE(268)
			::flixel::FlxSprite tmp24 = this->sprite_following_mouse;		HX_STACK_VAR(tmp24,"tmp24");
			HX_STACK_LINE(268)
			int tmp25 = tmp24->frameWidth;		HX_STACK_VAR(tmp25,"tmp25");
			HX_STACK_LINE(268)
			Float tmp26 = (Float(tmp25) / Float((int)2));		HX_STACK_VAR(tmp26,"tmp26");
			HX_STACK_LINE(268)
			Float tmp27 = (tmp23 - tmp26);		HX_STACK_VAR(tmp27,"tmp27");
			HX_STACK_LINE(268)
			::flixel::input::mouse::FlxMouse tmp28 = ::flixel::FlxG_obj::mouse;		HX_STACK_VAR(tmp28,"tmp28");
			HX_STACK_LINE(268)
			Float tmp29 = tmp28->y;		HX_STACK_VAR(tmp29,"tmp29");
			HX_STACK_LINE(268)
			::flixel::FlxSprite tmp30 = this->sprite_following_mouse;		HX_STACK_VAR(tmp30,"tmp30");
			HX_STACK_LINE(268)
			int tmp31 = tmp30->frameHeight;		HX_STACK_VAR(tmp31,"tmp31");
			HX_STACK_LINE(268)
			Float tmp32 = (Float(tmp31) / Float((int)2));		HX_STACK_VAR(tmp32,"tmp32");
			HX_STACK_LINE(268)
			Float tmp33 = (tmp29 - tmp32);		HX_STACK_VAR(tmp33,"tmp33");
			HX_STACK_LINE(268)
			tmp21->setPosition(tmp27,tmp33);
			HX_STACK_LINE(269)
			::flixel::FlxSprite tmp34 = this->sprite_following_mouse;		HX_STACK_VAR(tmp34,"tmp34");
			HX_STACK_LINE(269)
			::flixel::FlxSprite tmp35 = this->scrollbar_sprite;		HX_STACK_VAR(tmp35,"tmp35");
			HX_STACK_LINE(269)
			bool tmp36 = (tmp34 == tmp35);		HX_STACK_VAR(tmp36,"tmp36");
			HX_STACK_LINE(269)
			if ((tmp36)){
				HX_STACK_LINE(270)
				::flixel::FlxSprite tmp37 = this->sprite_following_mouse;		HX_STACK_VAR(tmp37,"tmp37");
				HX_STACK_LINE(270)
				Float tmp38 = lastPosX;		HX_STACK_VAR(tmp38,"tmp38");
				HX_STACK_LINE(270)
				tmp37->set_x(tmp38);
				HX_STACK_LINE(271)
				::List tmp39 = this->draggableWaystones;		HX_STACK_VAR(tmp39,"tmp39");
				HX_STACK_LINE(271)
				int tmp40 = tmp39->length;		HX_STACK_VAR(tmp40,"tmp40");
				HX_STACK_LINE(271)
				int tmp41 = (tmp40 + (int)1);		HX_STACK_VAR(tmp41,"tmp41");
				HX_STACK_LINE(271)
				int tmp42 = (tmp41 * (int)100);		HX_STACK_VAR(tmp42,"tmp42");
				HX_STACK_LINE(271)
				int tmp43 = ::flixel::FlxG_obj::height;		HX_STACK_VAR(tmp43,"tmp43");
				HX_STACK_LINE(271)
				int tmp44 = (tmp42 - tmp43);		HX_STACK_VAR(tmp44,"tmp44");
				HX_STACK_LINE(271)
				int tmp45 = ::flixel::FlxG_obj::height;		HX_STACK_VAR(tmp45,"tmp45");
				HX_STACK_LINE(271)
				int tmp46 = (tmp45 - (int)100);		HX_STACK_VAR(tmp46,"tmp46");
				HX_STACK_LINE(271)
				Float tmp47 = (Float(tmp44) / Float(tmp46));		HX_STACK_VAR(tmp47,"tmp47");
				HX_STACK_LINE(271)
				Float scale = tmp47;		HX_STACK_VAR(scale,"scale");
				HX_STACK_LINE(272)
				::flixel::FlxSprite tmp48 = this->sprite_following_mouse;		HX_STACK_VAR(tmp48,"tmp48");
				HX_STACK_LINE(272)
				Float tmp49 = tmp48->y;		HX_STACK_VAR(tmp49,"tmp49");
				HX_STACK_LINE(272)
				int tmp50 = ::flixel::FlxG_obj::height;		HX_STACK_VAR(tmp50,"tmp50");
				HX_STACK_LINE(272)
				int tmp51 = (tmp50 - (int)63);		HX_STACK_VAR(tmp51,"tmp51");
				HX_STACK_LINE(272)
				bool tmp52 = (tmp49 > tmp51);		HX_STACK_VAR(tmp52,"tmp52");
				HX_STACK_LINE(272)
				if ((tmp52)){
					HX_STACK_LINE(273)
					::flixel::FlxSprite tmp53 = this->sprite_following_mouse;		HX_STACK_VAR(tmp53,"tmp53");
					HX_STACK_LINE(273)
					int tmp54 = ::flixel::FlxG_obj::height;		HX_STACK_VAR(tmp54,"tmp54");
					HX_STACK_LINE(273)
					int tmp55 = (tmp54 - (int)63);		HX_STACK_VAR(tmp55,"tmp55");
					HX_STACK_LINE(273)
					tmp53->set_y(tmp55);
				}
				HX_STACK_LINE(275)
				::flixel::FlxSprite tmp53 = this->sprite_following_mouse;		HX_STACK_VAR(tmp53,"tmp53");
				HX_STACK_LINE(275)
				Float tmp54 = tmp53->y;		HX_STACK_VAR(tmp54,"tmp54");
				HX_STACK_LINE(275)
				bool tmp55 = (tmp54 < (int)100);		HX_STACK_VAR(tmp55,"tmp55");
				HX_STACK_LINE(275)
				if ((tmp55)){
					HX_STACK_LINE(276)
					::flixel::FlxSprite tmp56 = this->sprite_following_mouse;		HX_STACK_VAR(tmp56,"tmp56");
					HX_STACK_LINE(276)
					tmp56->set_y((int)100);
				}
				HX_STACK_LINE(278)
				::flixel::FlxSprite tmp56 = this->sprite_following_mouse;		HX_STACK_VAR(tmp56,"tmp56");
				HX_STACK_LINE(278)
				Float tmp57 = tmp56->y;		HX_STACK_VAR(tmp57,"tmp57");
				HX_STACK_LINE(278)
				Float tmp58 = lastPosY;		HX_STACK_VAR(tmp58,"tmp58");
				HX_STACK_LINE(278)
				Float tmp59 = (tmp57 - tmp58);		HX_STACK_VAR(tmp59,"tmp59");
				HX_STACK_LINE(278)
				Float changeY = tmp59;		HX_STACK_VAR(changeY,"changeY");
				HX_STACK_LINE(279)
				{
					HX_STACK_LINE(279)
					::List tmp60 = this->draggableWaystones;		HX_STACK_VAR(tmp60,"tmp60");
					HX_STACK_LINE(279)
					::_List::ListIterator tmp61 = ::_List::ListIterator_obj::__new(tmp60->h);		HX_STACK_VAR(tmp61,"tmp61");
					HX_STACK_LINE(279)
					::_List::ListIterator _g = tmp61;		HX_STACK_VAR(_g,"_g");
					HX_STACK_LINE(279)
					while((true)){
						HX_STACK_LINE(279)
						bool tmp62 = (_g->head != null());		HX_STACK_VAR(tmp62,"tmp62");
						HX_STACK_LINE(279)
						bool tmp63 = !(tmp62);		HX_STACK_VAR(tmp63,"tmp63");
						HX_STACK_LINE(279)
						if ((tmp63)){
							HX_STACK_LINE(279)
							break;
						}
						HX_STACK_LINE(279)
						Dynamic tmp64;		HX_STACK_VAR(tmp64,"tmp64");
						HX_STACK_LINE(279)
						{
							HX_STACK_LINE(279)
							Dynamic tmp65 = _g->head->__GetItem((int)0);		HX_STACK_VAR(tmp65,"tmp65");
							HX_STACK_LINE(279)
							_g->val = tmp65;
							HX_STACK_LINE(279)
							Dynamic tmp66 = _g->head->__GetItem((int)1);		HX_STACK_VAR(tmp66,"tmp66");
							HX_STACK_LINE(279)
							_g->head = tmp66;
							HX_STACK_LINE(279)
							tmp64 = _g->val;
						}
						HX_STACK_LINE(279)
						::DraggableWaystone waystone = ((::DraggableWaystone)(tmp64));		HX_STACK_VAR(waystone,"waystone");
						HX_STACK_LINE(280)
						{
							HX_STACK_LINE(280)
							::DraggableWaystone _g1 = waystone;		HX_STACK_VAR(_g1,"_g1");
							HX_STACK_LINE(280)
							Float tmp65 = _g1->y;		HX_STACK_VAR(tmp65,"tmp65");
							HX_STACK_LINE(280)
							Float tmp66 = (changeY * scale);		HX_STACK_VAR(tmp66,"tmp66");
							HX_STACK_LINE(280)
							Float tmp67 = (tmp65 - tmp66);		HX_STACK_VAR(tmp67,"tmp67");
							HX_STACK_LINE(280)
							_g1->set_y(tmp67);
						}
					}
				}
				HX_STACK_LINE(282)
				{
					HX_STACK_LINE(282)
					::List tmp60 = this->draggableWaystoneTexts;		HX_STACK_VAR(tmp60,"tmp60");
					HX_STACK_LINE(282)
					::_List::ListIterator tmp61 = ::_List::ListIterator_obj::__new(tmp60->h);		HX_STACK_VAR(tmp61,"tmp61");
					HX_STACK_LINE(282)
					::_List::ListIterator _g = tmp61;		HX_STACK_VAR(_g,"_g");
					HX_STACK_LINE(282)
					while((true)){
						HX_STACK_LINE(282)
						bool tmp62 = (_g->head != null());		HX_STACK_VAR(tmp62,"tmp62");
						HX_STACK_LINE(282)
						bool tmp63 = !(tmp62);		HX_STACK_VAR(tmp63,"tmp63");
						HX_STACK_LINE(282)
						if ((tmp63)){
							HX_STACK_LINE(282)
							break;
						}
						HX_STACK_LINE(282)
						Dynamic tmp64;		HX_STACK_VAR(tmp64,"tmp64");
						HX_STACK_LINE(282)
						{
							HX_STACK_LINE(282)
							Dynamic tmp65 = _g->head->__GetItem((int)0);		HX_STACK_VAR(tmp65,"tmp65");
							HX_STACK_LINE(282)
							_g->val = tmp65;
							HX_STACK_LINE(282)
							Dynamic tmp66 = _g->head->__GetItem((int)1);		HX_STACK_VAR(tmp66,"tmp66");
							HX_STACK_LINE(282)
							_g->head = tmp66;
							HX_STACK_LINE(282)
							tmp64 = _g->val;
						}
						HX_STACK_LINE(282)
						::flixel::text::FlxText waystone = ((::flixel::text::FlxText)(tmp64));		HX_STACK_VAR(waystone,"waystone");
						HX_STACK_LINE(283)
						{
							HX_STACK_LINE(283)
							::flixel::text::FlxText _g1 = waystone;		HX_STACK_VAR(_g1,"_g1");
							HX_STACK_LINE(283)
							Float tmp65 = _g1->y;		HX_STACK_VAR(tmp65,"tmp65");
							HX_STACK_LINE(283)
							Float tmp66 = (changeY * scale);		HX_STACK_VAR(tmp66,"tmp66");
							HX_STACK_LINE(283)
							Float tmp67 = (tmp65 - tmp66);		HX_STACK_VAR(tmp67,"tmp67");
							HX_STACK_LINE(283)
							_g1->set_y(tmp67);
						}
					}
				}
			}
		}
	}
return null();
}


Void MainState_obj::place( ::PlacedWaystone waystone){
{
		HX_STACK_FRAME("MainState","place",0xc2b036d1,"MainState.place","MainState.hx",291,0x5634cec6)
		HX_STACK_THIS(this)
		HX_STACK_ARG(waystone,"waystone")
		HX_STACK_LINE(292)
		::List tmp = this->waystones;		HX_STACK_VAR(tmp,"tmp");
		HX_STACK_LINE(292)
		::PlacedWaystone tmp1 = waystone;		HX_STACK_VAR(tmp1,"tmp1");
		HX_STACK_LINE(292)
		tmp->add(tmp1);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC1(MainState_obj,place,(void))

bool MainState_obj::isValidPlacement( int grid_x,int grid_y,::PlacedWaystone waystone){
	HX_STACK_FRAME("MainState","isValidPlacement",0x39631109,"MainState.isValidPlacement","MainState.hx",295,0x5634cec6)
	HX_STACK_THIS(this)
	HX_STACK_ARG(grid_x,"grid_x")
	HX_STACK_ARG(grid_y,"grid_y")
	HX_STACK_ARG(waystone,"waystone")
	HX_STACK_LINE(296)
	::String tmp = (grid_x + HX_HCSTRING(",","\x2c","\x00","\x00","\x00"));		HX_STACK_VAR(tmp,"tmp");
	HX_STACK_LINE(296)
	int tmp1 = grid_y;		HX_STACK_VAR(tmp1,"tmp1");
	HX_STACK_LINE(296)
	::String tmp2 = (tmp + tmp1);		HX_STACK_VAR(tmp2,"tmp2");
	HX_STACK_LINE(296)
	Dynamic tmp3 = hx::SourceInfo(HX_HCSTRING("MainState.hx","\xc6","\xce","\x34","\x56"),296,HX_HCSTRING("MainState","\xf8","\x1e","\x82","\x3f"),HX_HCSTRING("isValidPlacement","\xd3","\xca","\x87","\xfc"));		HX_STACK_VAR(tmp3,"tmp3");
	HX_STACK_LINE(296)
	::haxe::Log_obj::trace(tmp2,tmp3);
	HX_STACK_LINE(297)
	int tmp4 = grid_x;		HX_STACK_VAR(tmp4,"tmp4");
	HX_STACK_LINE(297)
	int tmp5 = (int)-4;		HX_STACK_VAR(tmp5,"tmp5");
	HX_STACK_LINE(297)
	bool tmp6 = (tmp4 <= tmp5);		HX_STACK_VAR(tmp6,"tmp6");
	HX_STACK_LINE(297)
	bool tmp7 = !(tmp6);		HX_STACK_VAR(tmp7,"tmp7");
	HX_STACK_LINE(297)
	bool tmp8 = tmp7;		HX_STACK_VAR(tmp8,"tmp8");
	HX_STACK_LINE(297)
	bool tmp9;		HX_STACK_VAR(tmp9,"tmp9");
	HX_STACK_LINE(297)
	if ((tmp8)){
		HX_STACK_LINE(297)
		int tmp10 = grid_y;		HX_STACK_VAR(tmp10,"tmp10");
		HX_STACK_LINE(297)
		int tmp11 = (int)-4;		HX_STACK_VAR(tmp11,"tmp11");
		HX_STACK_LINE(297)
		int tmp12 = tmp11;		HX_STACK_VAR(tmp12,"tmp12");
		HX_STACK_LINE(297)
		int tmp13 = tmp12;		HX_STACK_VAR(tmp13,"tmp13");
		HX_STACK_LINE(297)
		tmp9 = (tmp10 <= tmp13);
	}
	else{
		HX_STACK_LINE(297)
		tmp9 = true;
	}
	HX_STACK_LINE(297)
	bool tmp10 = !(tmp9);		HX_STACK_VAR(tmp10,"tmp10");
	HX_STACK_LINE(297)
	bool tmp11 = tmp10;		HX_STACK_VAR(tmp11,"tmp11");
	HX_STACK_LINE(297)
	bool tmp12;		HX_STACK_VAR(tmp12,"tmp12");
	HX_STACK_LINE(297)
	if ((tmp11)){
		HX_STACK_LINE(297)
		tmp12 = (grid_x >= (int)7);
	}
	else{
		HX_STACK_LINE(297)
		tmp12 = true;
	}
	HX_STACK_LINE(297)
	bool tmp13 = !(tmp12);		HX_STACK_VAR(tmp13,"tmp13");
	HX_STACK_LINE(297)
	bool tmp14;		HX_STACK_VAR(tmp14,"tmp14");
	HX_STACK_LINE(297)
	if ((tmp13)){
		HX_STACK_LINE(297)
		tmp14 = (grid_y >= (int)7);
	}
	else{
		HX_STACK_LINE(297)
		tmp14 = true;
	}
	HX_STACK_LINE(297)
	if ((tmp14)){
		HX_STACK_LINE(298)
		return false;
	}
	HX_STACK_LINE(300)
	::PlacedWaystone tmp15 = waystone;		HX_STACK_VAR(tmp15,"tmp15");
	HX_STACK_LINE(300)
	::flixel::FlxSprite tmp16 = this->sidePanel;		HX_STACK_VAR(tmp16,"tmp16");
	HX_STACK_LINE(300)
	bool tmp17 = ::flixel::util::FlxCollision_obj::pixelPerfectCheck(tmp15,tmp16,null(),null());		HX_STACK_VAR(tmp17,"tmp17");
	HX_STACK_LINE(300)
	if ((tmp17)){
		HX_STACK_LINE(301)
		return false;
	}
	HX_STACK_LINE(303)
	{
		HX_STACK_LINE(303)
		::List tmp18 = this->waystones;		HX_STACK_VAR(tmp18,"tmp18");
		HX_STACK_LINE(303)
		::_List::ListIterator tmp19 = ::_List::ListIterator_obj::__new(tmp18->h);		HX_STACK_VAR(tmp19,"tmp19");
		HX_STACK_LINE(303)
		::_List::ListIterator _g = tmp19;		HX_STACK_VAR(_g,"_g");
		HX_STACK_LINE(303)
		while((true)){
			HX_STACK_LINE(303)
			bool tmp20 = (_g->head != null());		HX_STACK_VAR(tmp20,"tmp20");
			HX_STACK_LINE(303)
			bool tmp21 = !(tmp20);		HX_STACK_VAR(tmp21,"tmp21");
			HX_STACK_LINE(303)
			if ((tmp21)){
				HX_STACK_LINE(303)
				break;
			}
			HX_STACK_LINE(303)
			Dynamic tmp22;		HX_STACK_VAR(tmp22,"tmp22");
			HX_STACK_LINE(303)
			{
				HX_STACK_LINE(303)
				Dynamic tmp23 = _g->head->__GetItem((int)0);		HX_STACK_VAR(tmp23,"tmp23");
				HX_STACK_LINE(303)
				_g->val = tmp23;
				HX_STACK_LINE(303)
				Dynamic tmp24 = _g->head->__GetItem((int)1);		HX_STACK_VAR(tmp24,"tmp24");
				HX_STACK_LINE(303)
				_g->head = tmp24;
				HX_STACK_LINE(303)
				tmp22 = _g->val;
			}
			HX_STACK_LINE(303)
			::PlacedWaystone otherWaystone = ((::PlacedWaystone)(tmp22));		HX_STACK_VAR(otherWaystone,"otherWaystone");
			HX_STACK_LINE(304)
			::PlacedWaystone tmp23 = waystone;		HX_STACK_VAR(tmp23,"tmp23");
			HX_STACK_LINE(304)
			::PlacedWaystone tmp24 = otherWaystone;		HX_STACK_VAR(tmp24,"tmp24");
			HX_STACK_LINE(304)
			bool tmp25 = ::flixel::util::FlxCollision_obj::pixelPerfectCheck(tmp23,tmp24,null(),null());		HX_STACK_VAR(tmp25,"tmp25");
			HX_STACK_LINE(304)
			if ((tmp25)){
				HX_STACK_LINE(305)
				return false;
			}
		}
	}
	HX_STACK_LINE(308)
	return true;
}


HX_DEFINE_DYNAMIC_FUNC3(MainState_obj,isValidPlacement,return )


MainState_obj::MainState_obj()
{
}

void MainState_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(MainState);
	HX_MARK_MEMBER_NAME(host,"host");
	HX_MARK_MEMBER_NAME(z0,"z0");
	HX_MARK_MEMBER_NAME(z1,"z1");
	HX_MARK_MEMBER_NAME(z2,"z2");
	HX_MARK_MEMBER_NAME(z3,"z3");
	HX_MARK_MEMBER_NAME(z4,"z4");
	HX_MARK_MEMBER_NAME(mouse_collider_sprite,"mouse_collider_sprite");
	HX_MARK_MEMBER_NAME(scrollbar_sprite,"scrollbar_sprite");
	HX_MARK_MEMBER_NAME(stats_text,"stats_text");
	HX_MARK_MEMBER_NAME(sidePanel,"sidePanel");
	HX_MARK_MEMBER_NAME(draggableWaystones,"draggableWaystones");
	HX_MARK_MEMBER_NAME(draggableWaystoneTexts,"draggableWaystoneTexts");
	HX_MARK_MEMBER_NAME(sprite_following_mouse,"sprite_following_mouse");
	HX_MARK_MEMBER_NAME(tooltipAppearTimer,"tooltipAppearTimer");
	HX_MARK_MEMBER_NAME(tooltip_group,"tooltip_group");
	HX_MARK_MEMBER_NAME(waystones,"waystones");
	::flixel::FlxState_obj::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

void MainState_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(host,"host");
	HX_VISIT_MEMBER_NAME(z0,"z0");
	HX_VISIT_MEMBER_NAME(z1,"z1");
	HX_VISIT_MEMBER_NAME(z2,"z2");
	HX_VISIT_MEMBER_NAME(z3,"z3");
	HX_VISIT_MEMBER_NAME(z4,"z4");
	HX_VISIT_MEMBER_NAME(mouse_collider_sprite,"mouse_collider_sprite");
	HX_VISIT_MEMBER_NAME(scrollbar_sprite,"scrollbar_sprite");
	HX_VISIT_MEMBER_NAME(stats_text,"stats_text");
	HX_VISIT_MEMBER_NAME(sidePanel,"sidePanel");
	HX_VISIT_MEMBER_NAME(draggableWaystones,"draggableWaystones");
	HX_VISIT_MEMBER_NAME(draggableWaystoneTexts,"draggableWaystoneTexts");
	HX_VISIT_MEMBER_NAME(sprite_following_mouse,"sprite_following_mouse");
	HX_VISIT_MEMBER_NAME(tooltipAppearTimer,"tooltipAppearTimer");
	HX_VISIT_MEMBER_NAME(tooltip_group,"tooltip_group");
	HX_VISIT_MEMBER_NAME(waystones,"waystones");
	::flixel::FlxState_obj::__Visit(HX_VISIT_ARG);
}

Dynamic MainState_obj::__Field(const ::String &inName,hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 2:
		if (HX_FIELD_EQ(inName,"z0") ) { return z0; }
		if (HX_FIELD_EQ(inName,"z1") ) { return z1; }
		if (HX_FIELD_EQ(inName,"z2") ) { return z2; }
		if (HX_FIELD_EQ(inName,"z3") ) { return z3; }
		if (HX_FIELD_EQ(inName,"z4") ) { return z4; }
		break;
	case 4:
		if (HX_FIELD_EQ(inName,"host") ) { return host; }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"place") ) { return place_dyn(); }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"create") ) { return create_dyn(); }
		if (HX_FIELD_EQ(inName,"update") ) { return update_dyn(); }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"destroy") ) { return destroy_dyn(); }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"sidePanel") ) { return sidePanel; }
		if (HX_FIELD_EQ(inName,"waystones") ) { return waystones; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"stats_text") ) { return stats_text; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"tooltip_group") ) { return tooltip_group; }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"scrollbar_sprite") ) { return scrollbar_sprite; }
		if (HX_FIELD_EQ(inName,"isValidPlacement") ) { return isValidPlacement_dyn(); }
		break;
	case 18:
		if (HX_FIELD_EQ(inName,"draggableWaystones") ) { return draggableWaystones; }
		if (HX_FIELD_EQ(inName,"tooltipAppearTimer") ) { return tooltipAppearTimer; }
		break;
	case 21:
		if (HX_FIELD_EQ(inName,"mouse_collider_sprite") ) { return mouse_collider_sprite; }
		break;
	case 22:
		if (HX_FIELD_EQ(inName,"draggableWaystoneTexts") ) { return draggableWaystoneTexts; }
		if (HX_FIELD_EQ(inName,"sprite_following_mouse") ) { return sprite_following_mouse; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic MainState_obj::__SetField(const ::String &inName,const Dynamic &inValue,hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 2:
		if (HX_FIELD_EQ(inName,"z0") ) { z0=inValue.Cast< ::flixel::group::FlxGroup >(); return inValue; }
		if (HX_FIELD_EQ(inName,"z1") ) { z1=inValue.Cast< ::flixel::group::FlxGroup >(); return inValue; }
		if (HX_FIELD_EQ(inName,"z2") ) { z2=inValue.Cast< ::flixel::group::FlxGroup >(); return inValue; }
		if (HX_FIELD_EQ(inName,"z3") ) { z3=inValue.Cast< ::flixel::group::FlxGroup >(); return inValue; }
		if (HX_FIELD_EQ(inName,"z4") ) { z4=inValue.Cast< ::flixel::group::FlxGroup >(); return inValue; }
		break;
	case 4:
		if (HX_FIELD_EQ(inName,"host") ) { host=inValue.Cast< ::String >(); return inValue; }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"sidePanel") ) { sidePanel=inValue.Cast< ::flixel::FlxSprite >(); return inValue; }
		if (HX_FIELD_EQ(inName,"waystones") ) { waystones=inValue.Cast< ::List >(); return inValue; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"stats_text") ) { stats_text=inValue.Cast< ::flixel::text::FlxText >(); return inValue; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"tooltip_group") ) { tooltip_group=inValue.Cast< ::flixel::group::FlxGroup >(); return inValue; }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"scrollbar_sprite") ) { scrollbar_sprite=inValue.Cast< ::flixel::FlxSprite >(); return inValue; }
		break;
	case 18:
		if (HX_FIELD_EQ(inName,"draggableWaystones") ) { draggableWaystones=inValue.Cast< ::List >(); return inValue; }
		if (HX_FIELD_EQ(inName,"tooltipAppearTimer") ) { tooltipAppearTimer=inValue.Cast< int >(); return inValue; }
		break;
	case 21:
		if (HX_FIELD_EQ(inName,"mouse_collider_sprite") ) { mouse_collider_sprite=inValue.Cast< ::flixel::FlxSprite >(); return inValue; }
		break;
	case 22:
		if (HX_FIELD_EQ(inName,"draggableWaystoneTexts") ) { draggableWaystoneTexts=inValue.Cast< ::List >(); return inValue; }
		if (HX_FIELD_EQ(inName,"sprite_following_mouse") ) { sprite_following_mouse=inValue.Cast< ::flixel::FlxSprite >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void MainState_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_HCSTRING("host","\x68","\xcf","\x12","\x45"));
	outFields->push(HX_HCSTRING("z0","\x76","\x6a","\x00","\x00"));
	outFields->push(HX_HCSTRING("z1","\x77","\x6a","\x00","\x00"));
	outFields->push(HX_HCSTRING("z2","\x78","\x6a","\x00","\x00"));
	outFields->push(HX_HCSTRING("z3","\x79","\x6a","\x00","\x00"));
	outFields->push(HX_HCSTRING("z4","\x7a","\x6a","\x00","\x00"));
	outFields->push(HX_HCSTRING("mouse_collider_sprite","\x96","\xcf","\x0d","\xbf"));
	outFields->push(HX_HCSTRING("scrollbar_sprite","\x7e","\xb6","\xac","\x56"));
	outFields->push(HX_HCSTRING("stats_text","\x0d","\xe2","\xc3","\x75"));
	outFields->push(HX_HCSTRING("sidePanel","\xed","\xb9","\x10","\x29"));
	outFields->push(HX_HCSTRING("draggableWaystones","\x10","\xa0","\x49","\x25"));
	outFields->push(HX_HCSTRING("draggableWaystoneTexts","\x23","\xed","\xb4","\xba"));
	outFields->push(HX_HCSTRING("sprite_following_mouse","\xbd","\xb0","\x3e","\x0e"));
	outFields->push(HX_HCSTRING("tooltipAppearTimer","\xad","\xb0","\x8d","\x98"));
	outFields->push(HX_HCSTRING("tooltip_group","\xc3","\xcb","\x68","\xef"));
	outFields->push(HX_HCSTRING("waystones","\xdd","\x76","\x32","\x71"));
	super::__GetFields(outFields);
};

#if HXCPP_SCRIPTABLE
static hx::StorageInfo sMemberStorageInfo[] = {
	{hx::fsString,(int)offsetof(MainState_obj,host),HX_HCSTRING("host","\x68","\xcf","\x12","\x45")},
	{hx::fsObject /*::flixel::group::FlxGroup*/ ,(int)offsetof(MainState_obj,z0),HX_HCSTRING("z0","\x76","\x6a","\x00","\x00")},
	{hx::fsObject /*::flixel::group::FlxGroup*/ ,(int)offsetof(MainState_obj,z1),HX_HCSTRING("z1","\x77","\x6a","\x00","\x00")},
	{hx::fsObject /*::flixel::group::FlxGroup*/ ,(int)offsetof(MainState_obj,z2),HX_HCSTRING("z2","\x78","\x6a","\x00","\x00")},
	{hx::fsObject /*::flixel::group::FlxGroup*/ ,(int)offsetof(MainState_obj,z3),HX_HCSTRING("z3","\x79","\x6a","\x00","\x00")},
	{hx::fsObject /*::flixel::group::FlxGroup*/ ,(int)offsetof(MainState_obj,z4),HX_HCSTRING("z4","\x7a","\x6a","\x00","\x00")},
	{hx::fsObject /*::flixel::FlxSprite*/ ,(int)offsetof(MainState_obj,mouse_collider_sprite),HX_HCSTRING("mouse_collider_sprite","\x96","\xcf","\x0d","\xbf")},
	{hx::fsObject /*::flixel::FlxSprite*/ ,(int)offsetof(MainState_obj,scrollbar_sprite),HX_HCSTRING("scrollbar_sprite","\x7e","\xb6","\xac","\x56")},
	{hx::fsObject /*::flixel::text::FlxText*/ ,(int)offsetof(MainState_obj,stats_text),HX_HCSTRING("stats_text","\x0d","\xe2","\xc3","\x75")},
	{hx::fsObject /*::flixel::FlxSprite*/ ,(int)offsetof(MainState_obj,sidePanel),HX_HCSTRING("sidePanel","\xed","\xb9","\x10","\x29")},
	{hx::fsObject /*::List*/ ,(int)offsetof(MainState_obj,draggableWaystones),HX_HCSTRING("draggableWaystones","\x10","\xa0","\x49","\x25")},
	{hx::fsObject /*::List*/ ,(int)offsetof(MainState_obj,draggableWaystoneTexts),HX_HCSTRING("draggableWaystoneTexts","\x23","\xed","\xb4","\xba")},
	{hx::fsObject /*::flixel::FlxSprite*/ ,(int)offsetof(MainState_obj,sprite_following_mouse),HX_HCSTRING("sprite_following_mouse","\xbd","\xb0","\x3e","\x0e")},
	{hx::fsInt,(int)offsetof(MainState_obj,tooltipAppearTimer),HX_HCSTRING("tooltipAppearTimer","\xad","\xb0","\x8d","\x98")},
	{hx::fsObject /*::flixel::group::FlxGroup*/ ,(int)offsetof(MainState_obj,tooltip_group),HX_HCSTRING("tooltip_group","\xc3","\xcb","\x68","\xef")},
	{hx::fsObject /*::List*/ ,(int)offsetof(MainState_obj,waystones),HX_HCSTRING("waystones","\xdd","\x76","\x32","\x71")},
	{ hx::fsUnknown, 0, null()}
};
static hx::StaticInfo *sStaticStorageInfo = 0;
#endif

static ::String sMemberFields[] = {
	HX_HCSTRING("host","\x68","\xcf","\x12","\x45"),
	HX_HCSTRING("z0","\x76","\x6a","\x00","\x00"),
	HX_HCSTRING("z1","\x77","\x6a","\x00","\x00"),
	HX_HCSTRING("z2","\x78","\x6a","\x00","\x00"),
	HX_HCSTRING("z3","\x79","\x6a","\x00","\x00"),
	HX_HCSTRING("z4","\x7a","\x6a","\x00","\x00"),
	HX_HCSTRING("mouse_collider_sprite","\x96","\xcf","\x0d","\xbf"),
	HX_HCSTRING("scrollbar_sprite","\x7e","\xb6","\xac","\x56"),
	HX_HCSTRING("stats_text","\x0d","\xe2","\xc3","\x75"),
	HX_HCSTRING("sidePanel","\xed","\xb9","\x10","\x29"),
	HX_HCSTRING("draggableWaystones","\x10","\xa0","\x49","\x25"),
	HX_HCSTRING("draggableWaystoneTexts","\x23","\xed","\xb4","\xba"),
	HX_HCSTRING("create","\xfc","\x66","\x0f","\x7c"),
	HX_HCSTRING("sprite_following_mouse","\xbd","\xb0","\x3e","\x0e"),
	HX_HCSTRING("destroy","\xfa","\x2c","\x86","\x24"),
	HX_HCSTRING("tooltipAppearTimer","\xad","\xb0","\x8d","\x98"),
	HX_HCSTRING("tooltip_group","\xc3","\xcb","\x68","\xef"),
	HX_HCSTRING("update","\x09","\x86","\x05","\x87"),
	HX_HCSTRING("waystones","\xdd","\x76","\x32","\x71"),
	HX_HCSTRING("place","\xc7","\xf4","\x8d","\xc4"),
	HX_HCSTRING("isValidPlacement","\xd3","\xca","\x87","\xfc"),
	::String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(MainState_obj::__mClass,"__mClass");
};

#ifdef HXCPP_VISIT_ALLOCS
static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(MainState_obj::__mClass,"__mClass");
};

#endif

hx::Class MainState_obj::__mClass;

void MainState_obj::__register()
{
	hx::Static(__mClass) = new hx::Class_obj();
	__mClass->mName = HX_HCSTRING("MainState","\xf8","\x1e","\x82","\x3f");
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &hx::Class_obj::GetNoStaticField;
	__mClass->mSetStaticField = &hx::Class_obj::SetNoStaticField;
	__mClass->mMarkFunc = sMarkStatics;
	__mClass->mStatics = hx::Class_obj::dupFunctions(0 /* sStaticFields */);
	__mClass->mMembers = hx::Class_obj::dupFunctions(sMemberFields);
	__mClass->mCanCast = hx::TCanCast< MainState_obj >;
#ifdef HXCPP_VISIT_ALLOCS
	__mClass->mVisitFunc = sVisitStatics;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = sStaticStorageInfo;
#endif
	hx::RegisterClass(__mClass->mName, __mClass);
}

