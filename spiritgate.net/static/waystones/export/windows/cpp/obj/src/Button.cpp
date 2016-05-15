#include <hxcpp.h>

#ifndef INCLUDED_Button
#include <Button.h>
#endif
#ifndef INCLUDED_MainState
#include <MainState.h>
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
#ifndef INCLUDED_flixel_animation_FlxAnimationController
#include <flixel/animation/FlxAnimationController.h>
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

Void Button_obj::__construct(hx::Null< Float >  __o_X,hx::Null< Float >  __o_Y,::MainState state,::String text,Dynamic onClick)
{
HX_STACK_FRAME("Button","new",0x9489e804,"Button.new","Button.hx",19,0xf1be03ec)
HX_STACK_THIS(this)
HX_STACK_ARG(__o_X,"X")
HX_STACK_ARG(__o_Y,"Y")
HX_STACK_ARG(state,"state")
HX_STACK_ARG(text,"text")
HX_STACK_ARG(onClick,"onClick")
Float X = __o_X.Default(0);
Float Y = __o_Y.Default(0);
{
	HX_STACK_LINE(22)
	this->onClickCooldown = (int)0;
	HX_STACK_LINE(24)
	Float tmp = X;		HX_STACK_VAR(tmp,"tmp");
	HX_STACK_LINE(24)
	Float tmp1 = Y;		HX_STACK_VAR(tmp1,"tmp1");
	HX_STACK_LINE(24)
	super::__construct(tmp,tmp1,null());
	HX_STACK_LINE(26)
	this->state = state;
	HX_STACK_LINE(27)
	this->loadGraphic(HX_HCSTRING("assets/images/button.png","\x98","\x1b","\xb6","\xcd"),true,(int)130,(int)40,null(),null());
	HX_STACK_LINE(28)
	::flixel::animation::FlxAnimationController tmp2 = this->animation;		HX_STACK_VAR(tmp2,"tmp2");
	HX_STACK_LINE(28)
	tmp2->add(HX_HCSTRING("default","\xc1","\xd8","\xc3","\x9b"),Array_obj< int >::__new().Add((int)0),null(),null());
	HX_STACK_LINE(29)
	::flixel::animation::FlxAnimationController tmp3 = this->animation;		HX_STACK_VAR(tmp3,"tmp3");
	HX_STACK_LINE(29)
	tmp3->add(HX_HCSTRING("hover","\xbc","\xe5","\x64","\x2b"),Array_obj< int >::__new().Add((int)1),null(),null());
	HX_STACK_LINE(30)
	::flixel::animation::FlxAnimationController tmp4 = this->animation;		HX_STACK_VAR(tmp4,"tmp4");
	HX_STACK_LINE(30)
	tmp4->add(HX_HCSTRING("pressed","\xa2","\xd2","\xe6","\x39"),Array_obj< int >::__new().Add((int)2),null(),null());
	HX_STACK_LINE(31)
	state->z2->add(hx::ObjectPtr<OBJ_>(this));
	HX_STACK_LINE(32)
	::flixel::animation::FlxAnimationController tmp5 = this->animation;		HX_STACK_VAR(tmp5,"tmp5");
	HX_STACK_LINE(32)
	tmp5->play(HX_HCSTRING("default","\xc1","\xd8","\xc3","\x9b"),true,null());
	HX_STACK_LINE(33)
	Float tmp6 = (X + ((Float)2.5));		HX_STACK_VAR(tmp6,"tmp6");
	HX_STACK_LINE(33)
	Float tmp7 = (Y + ((Float)2.5));		HX_STACK_VAR(tmp7,"tmp7");
	HX_STACK_LINE(33)
	::String tmp8 = text;		HX_STACK_VAR(tmp8,"tmp8");
	HX_STACK_LINE(33)
	::flixel::text::FlxText tmp9 = ::flixel::text::FlxText_obj::__new(tmp6,tmp7,(int)125,tmp8,(int)20,null());		HX_STACK_VAR(tmp9,"tmp9");
	HX_STACK_LINE(33)
	::flixel::text::FlxText flxtext = tmp9;		HX_STACK_VAR(flxtext,"flxtext");
	HX_STACK_LINE(34)
	flxtext->set_alignment(HX_HCSTRING("center","\xd5","\x25","\xdb","\x05"));
	HX_STACK_LINE(35)
	::flixel::text::FlxText tmp10 = flxtext;		HX_STACK_VAR(tmp10,"tmp10");
	HX_STACK_LINE(35)
	state->z2->add(tmp10);
	HX_STACK_LINE(37)
	this->onClick = onClick;
}
;
	return null();
}

//Button_obj::~Button_obj() { }

Dynamic Button_obj::__CreateEmpty() { return  new Button_obj; }
hx::ObjectPtr< Button_obj > Button_obj::__new(hx::Null< Float >  __o_X,hx::Null< Float >  __o_Y,::MainState state,::String text,Dynamic onClick)
{  hx::ObjectPtr< Button_obj > _result_ = new Button_obj();
	_result_->__construct(__o_X,__o_Y,state,text,onClick);
	return _result_;}

Dynamic Button_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< Button_obj > _result_ = new Button_obj();
	_result_->__construct(inArgs[0],inArgs[1],inArgs[2],inArgs[3],inArgs[4]);
	return _result_;}

Void Button_obj::update( ){
{
		HX_STACK_FRAME("Button","update",0x98decce5,"Button.update","Button.hx",39,0xf1be03ec)
		HX_STACK_THIS(this)
		HX_STACK_LINE(40)
		::flixel::animation::FlxAnimationController tmp = this->animation;		HX_STACK_VAR(tmp,"tmp");
		HX_STACK_LINE(40)
		tmp->play(HX_HCSTRING("default","\xc1","\xd8","\xc3","\x9b"),true,null());
		HX_STACK_LINE(41)
		::MainState tmp1 = this->state;		HX_STACK_VAR(tmp1,"tmp1");
		HX_STACK_LINE(41)
		::flixel::FlxSprite tmp2 = tmp1->mouse_collider_sprite;		HX_STACK_VAR(tmp2,"tmp2");
		HX_STACK_LINE(41)
		bool tmp3 = ::flixel::util::FlxCollision_obj::pixelPerfectCheck(tmp2,hx::ObjectPtr<OBJ_>(this),null(),null());		HX_STACK_VAR(tmp3,"tmp3");
		HX_STACK_LINE(41)
		if ((tmp3)){
			HX_STACK_LINE(42)
			bool tmp4;		HX_STACK_VAR(tmp4,"tmp4");
			HX_STACK_LINE(42)
			{
				HX_STACK_LINE(42)
				::flixel::input::mouse::FlxMouse tmp5 = ::flixel::FlxG_obj::mouse;		HX_STACK_VAR(tmp5,"tmp5");
				HX_STACK_LINE(42)
				::flixel::input::mouse::FlxMouseButton _this = tmp5->_leftButton;		HX_STACK_VAR(_this,"_this");
				HX_STACK_LINE(42)
				bool tmp6 = (_this->current == (int)2);		HX_STACK_VAR(tmp6,"tmp6");
				HX_STACK_LINE(42)
				bool tmp7 = !(tmp6);		HX_STACK_VAR(tmp7,"tmp7");
				HX_STACK_LINE(42)
				if ((tmp7)){
					HX_STACK_LINE(42)
					tmp4 = (_this->current == (int)-2);
				}
				else{
					HX_STACK_LINE(42)
					tmp4 = true;
				}
			}
			HX_STACK_LINE(42)
			if ((tmp4)){
				HX_STACK_LINE(43)
				::flixel::animation::FlxAnimationController tmp5 = this->animation;		HX_STACK_VAR(tmp5,"tmp5");
				HX_STACK_LINE(43)
				tmp5->play(HX_HCSTRING("pressed","\xa2","\xd2","\xe6","\x39"),true,null());
				HX_STACK_LINE(44)
				this->onClickCooldown = (int)4;
				HX_STACK_LINE(45)
				this->onClick();
			}
			else{
				HX_STACK_LINE(47)
				int tmp5 = this->onClickCooldown;		HX_STACK_VAR(tmp5,"tmp5");
				HX_STACK_LINE(47)
				bool tmp6 = (tmp5 == (int)0);		HX_STACK_VAR(tmp6,"tmp6");
				HX_STACK_LINE(47)
				if ((tmp6)){
					HX_STACK_LINE(48)
					::flixel::animation::FlxAnimationController tmp7 = this->animation;		HX_STACK_VAR(tmp7,"tmp7");
					HX_STACK_LINE(48)
					tmp7->play(HX_HCSTRING("hover","\xbc","\xe5","\x64","\x2b"),true,null());
				}
			}
		}
		HX_STACK_LINE(51)
		int tmp4 = this->onClickCooldown;		HX_STACK_VAR(tmp4,"tmp4");
		HX_STACK_LINE(51)
		bool tmp5 = (tmp4 > (int)0);		HX_STACK_VAR(tmp5,"tmp5");
		HX_STACK_LINE(51)
		if ((tmp5)){
			HX_STACK_LINE(52)
			(this->onClickCooldown)--;
		}
	}
return null();
}



Button_obj::Button_obj()
{
}

void Button_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(Button);
	HX_MARK_MEMBER_NAME(state,"state");
	HX_MARK_MEMBER_NAME(onClick,"onClick");
	HX_MARK_MEMBER_NAME(onClickCooldown,"onClickCooldown");
	::flixel::FlxSprite_obj::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

void Button_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(state,"state");
	HX_VISIT_MEMBER_NAME(onClick,"onClick");
	HX_VISIT_MEMBER_NAME(onClickCooldown,"onClickCooldown");
	::flixel::FlxSprite_obj::__Visit(HX_VISIT_ARG);
}

Dynamic Button_obj::__Field(const ::String &inName,hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"state") ) { return state; }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"update") ) { return update_dyn(); }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"onClick") ) { return onClick; }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"onClickCooldown") ) { return onClickCooldown; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic Button_obj::__SetField(const ::String &inName,const Dynamic &inValue,hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"state") ) { state=inValue.Cast< ::MainState >(); return inValue; }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"onClick") ) { onClick=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"onClickCooldown") ) { onClickCooldown=inValue.Cast< int >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void Button_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_HCSTRING("state","\x11","\x76","\x0b","\x84"));
	outFields->push(HX_HCSTRING("onClickCooldown","\x74","\x73","\xf8","\x73"));
	super::__GetFields(outFields);
};

#if HXCPP_SCRIPTABLE
static hx::StorageInfo sMemberStorageInfo[] = {
	{hx::fsObject /*::MainState*/ ,(int)offsetof(Button_obj,state),HX_HCSTRING("state","\x11","\x76","\x0b","\x84")},
	{hx::fsObject /*Dynamic*/ ,(int)offsetof(Button_obj,onClick),HX_HCSTRING("onClick","\xa9","\x1a","\x9c","\xde")},
	{hx::fsInt,(int)offsetof(Button_obj,onClickCooldown),HX_HCSTRING("onClickCooldown","\x74","\x73","\xf8","\x73")},
	{ hx::fsUnknown, 0, null()}
};
static hx::StaticInfo *sStaticStorageInfo = 0;
#endif

static ::String sMemberFields[] = {
	HX_HCSTRING("state","\x11","\x76","\x0b","\x84"),
	HX_HCSTRING("onClick","\xa9","\x1a","\x9c","\xde"),
	HX_HCSTRING("onClickCooldown","\x74","\x73","\xf8","\x73"),
	HX_HCSTRING("update","\x09","\x86","\x05","\x87"),
	::String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(Button_obj::__mClass,"__mClass");
};

#ifdef HXCPP_VISIT_ALLOCS
static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(Button_obj::__mClass,"__mClass");
};

#endif

hx::Class Button_obj::__mClass;

void Button_obj::__register()
{
	hx::Static(__mClass) = new hx::Class_obj();
	__mClass->mName = HX_HCSTRING("Button","\x12","\xd6","\x74","\x0e");
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &hx::Class_obj::GetNoStaticField;
	__mClass->mSetStaticField = &hx::Class_obj::SetNoStaticField;
	__mClass->mMarkFunc = sMarkStatics;
	__mClass->mStatics = hx::Class_obj::dupFunctions(0 /* sStaticFields */);
	__mClass->mMembers = hx::Class_obj::dupFunctions(sMemberFields);
	__mClass->mCanCast = hx::TCanCast< Button_obj >;
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

