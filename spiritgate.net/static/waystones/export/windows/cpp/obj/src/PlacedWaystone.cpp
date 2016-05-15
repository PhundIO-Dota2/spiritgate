#include <hxcpp.h>

#include "hxMath.h"
#ifndef INCLUDED_List
#include <List.h>
#endif
#ifndef INCLUDED_MainState
#include <MainState.h>
#endif
#ifndef INCLUDED_PlacedWaystone
#include <PlacedWaystone.h>
#endif
#ifndef INCLUDED_flixel_FlxBasic
#include <flixel/FlxBasic.h>
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
#ifndef INCLUDED_flixel_interfaces_IFlxDestroyable
#include <flixel/interfaces/IFlxDestroyable.h>
#endif
#ifndef INCLUDED_flixel_interfaces_IFlxPooled
#include <flixel/interfaces/IFlxPooled.h>
#endif
#ifndef INCLUDED_flixel_util_FlxPoint
#include <flixel/util/FlxPoint.h>
#endif

Void PlacedWaystone_obj::__construct(hx::Null< Float >  __o_X,hx::Null< Float >  __o_Y,::MainState state,::String shape,Array< ::String > stone_properties,::String name)
{
HX_STACK_FRAME("PlacedWaystone","new",0x28525a45,"PlacedWaystone.new","PlacedWaystone.hx",25,0xc47c54cb)
HX_STACK_THIS(this)
HX_STACK_ARG(__o_X,"X")
HX_STACK_ARG(__o_Y,"Y")
HX_STACK_ARG(state,"state")
HX_STACK_ARG(shape,"shape")
HX_STACK_ARG(stone_properties,"stone_properties")
HX_STACK_ARG(name,"name")
Float X = __o_X.Default(0);
Float Y = __o_Y.Default(0);
{
	HX_STACK_LINE(26)
	Float tmp = X;		HX_STACK_VAR(tmp,"tmp");
	HX_STACK_LINE(26)
	Float tmp1 = Y;		HX_STACK_VAR(tmp1,"tmp1");
	HX_STACK_LINE(26)
	super::__construct(tmp,tmp1,null());
	HX_STACK_LINE(27)
	this->state = state;
	HX_STACK_LINE(28)
	this->shape = shape;
	HX_STACK_LINE(29)
	::String tmp2 = (HX_HCSTRING("assets/images/","\xab","\x47","\xcb","\x9f") + shape);		HX_STACK_VAR(tmp2,"tmp2");
	HX_STACK_LINE(29)
	::String tmp3 = (tmp2 + HX_HCSTRING(".png","\x3b","\x2d","\xbd","\x1e"));		HX_STACK_VAR(tmp3,"tmp3");
	HX_STACK_LINE(29)
	this->loadGraphic(tmp3,null(),null(),null(),null(),null());
	HX_STACK_LINE(30)
	state->z1->add(hx::ObjectPtr<OBJ_>(this));
	HX_STACK_LINE(31)
	this->stone_properties = stone_properties;
	HX_STACK_LINE(32)
	this->name = name;
}
;
	return null();
}

//PlacedWaystone_obj::~PlacedWaystone_obj() { }

Dynamic PlacedWaystone_obj::__CreateEmpty() { return  new PlacedWaystone_obj; }
hx::ObjectPtr< PlacedWaystone_obj > PlacedWaystone_obj::__new(hx::Null< Float >  __o_X,hx::Null< Float >  __o_Y,::MainState state,::String shape,Array< ::String > stone_properties,::String name)
{  hx::ObjectPtr< PlacedWaystone_obj > _result_ = new PlacedWaystone_obj();
	_result_->__construct(__o_X,__o_Y,state,shape,stone_properties,name);
	return _result_;}

Dynamic PlacedWaystone_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< PlacedWaystone_obj > _result_ = new PlacedWaystone_obj();
	_result_->__construct(inArgs[0],inArgs[1],inArgs[2],inArgs[3],inArgs[4],inArgs[5]);
	return _result_;}

Void PlacedWaystone_obj::onMouseDown( ::PlacedWaystone block){
{
		HX_STACK_FRAME("PlacedWaystone","onMouseDown",0x4a280aed,"PlacedWaystone.onMouseDown","PlacedWaystone.hx",35,0xc47c54cb)
		HX_STACK_THIS(this)
		HX_STACK_ARG(block,"block")
		HX_STACK_LINE(36)
		::MainState tmp = this->state;		HX_STACK_VAR(tmp,"tmp");
		HX_STACK_LINE(36)
		::flixel::FlxSprite tmp1 = tmp->sprite_following_mouse;		HX_STACK_VAR(tmp1,"tmp1");
		HX_STACK_LINE(36)
		bool tmp2 = (tmp1 == null());		HX_STACK_VAR(tmp2,"tmp2");
		HX_STACK_LINE(36)
		if ((tmp2)){
			HX_STACK_LINE(37)
			::MainState tmp3 = this->state;		HX_STACK_VAR(tmp3,"tmp3");
			HX_STACK_LINE(37)
			::PlacedWaystone tmp4 = block;		HX_STACK_VAR(tmp4,"tmp4");
			HX_STACK_LINE(37)
			tmp3->z1->remove(tmp4,null());
			HX_STACK_LINE(38)
			::MainState tmp5 = this->state;		HX_STACK_VAR(tmp5,"tmp5");
			HX_STACK_LINE(38)
			::PlacedWaystone tmp6 = block;		HX_STACK_VAR(tmp6,"tmp6");
			HX_STACK_LINE(38)
			tmp5->z4->add(tmp6);
			HX_STACK_LINE(39)
			::MainState tmp7 = this->state;		HX_STACK_VAR(tmp7,"tmp7");
			HX_STACK_LINE(39)
			tmp7->sprite_following_mouse = block;
			HX_STACK_LINE(40)
			::MainState tmp8 = this->state;		HX_STACK_VAR(tmp8,"tmp8");
			HX_STACK_LINE(40)
			::flixel::util::FlxPoint tmp9 = tmp8->sprite_following_mouse->scale;		HX_STACK_VAR(tmp9,"tmp9");
			HX_STACK_LINE(40)
			tmp9->set((int)1,(int)1);
			HX_STACK_LINE(41)
			block->updateHitbox();
			HX_STACK_LINE(42)
			::MainState tmp10 = this->state;		HX_STACK_VAR(tmp10,"tmp10");
			HX_STACK_LINE(42)
			::PlacedWaystone tmp11 = block;		HX_STACK_VAR(tmp11,"tmp11");
			HX_STACK_LINE(42)
			tmp10->waystones->remove(tmp11);
		}
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC1(PlacedWaystone_obj,onMouseDown,(void))

Void PlacedWaystone_obj::onMouseUp( ::PlacedWaystone block){
{
		HX_STACK_FRAME("PlacedWaystone","onMouseUp",0x01dc3026,"PlacedWaystone.onMouseUp","PlacedWaystone.hx",45,0xc47c54cb)
		HX_STACK_THIS(this)
		HX_STACK_ARG(block,"block")
		HX_STACK_LINE(46)
		Float tmp = block->x;		HX_STACK_VAR(tmp,"tmp");
		HX_STACK_LINE(46)
		int tmp1 = ::flixel::FlxG_obj::width;		HX_STACK_VAR(tmp1,"tmp1");
		HX_STACK_LINE(46)
		Float tmp2 = (tmp - tmp1);		HX_STACK_VAR(tmp2,"tmp2");
		HX_STACK_LINE(46)
		Float tmp3 = (tmp2 + (int)512);		HX_STACK_VAR(tmp3,"tmp3");
		HX_STACK_LINE(46)
		Float tmp4 = (Float(tmp3) / Float((int)128));		HX_STACK_VAR(tmp4,"tmp4");
		HX_STACK_LINE(46)
		int tmp5 = ::Math_obj::round(tmp4);		HX_STACK_VAR(tmp5,"tmp5");
		HX_STACK_LINE(46)
		int grid_x = tmp5;		HX_STACK_VAR(grid_x,"grid_x");
		HX_STACK_LINE(47)
		Float tmp6 = block->y;		HX_STACK_VAR(tmp6,"tmp6");
		HX_STACK_LINE(47)
		int tmp7 = ::flixel::FlxG_obj::height;		HX_STACK_VAR(tmp7,"tmp7");
		HX_STACK_LINE(47)
		Float tmp8 = (tmp6 - tmp7);		HX_STACK_VAR(tmp8,"tmp8");
		HX_STACK_LINE(47)
		Float tmp9 = (tmp8 + (int)512);		HX_STACK_VAR(tmp9,"tmp9");
		HX_STACK_LINE(47)
		Float tmp10 = (Float(tmp9) / Float((int)128));		HX_STACK_VAR(tmp10,"tmp10");
		HX_STACK_LINE(47)
		int tmp11 = ::Math_obj::round(tmp10);		HX_STACK_VAR(tmp11,"tmp11");
		HX_STACK_LINE(47)
		int grid_y = tmp11;		HX_STACK_VAR(grid_y,"grid_y");
		HX_STACK_LINE(49)
		int tmp12 = (grid_x * (int)128);		HX_STACK_VAR(tmp12,"tmp12");
		HX_STACK_LINE(49)
		int tmp13 = ::flixel::FlxG_obj::width;		HX_STACK_VAR(tmp13,"tmp13");
		HX_STACK_LINE(49)
		int tmp14 = (tmp12 + tmp13);		HX_STACK_VAR(tmp14,"tmp14");
		HX_STACK_LINE(49)
		int tmp15 = (tmp14 - (int)512);		HX_STACK_VAR(tmp15,"tmp15");
		HX_STACK_LINE(49)
		block->set_x(tmp15);
		HX_STACK_LINE(50)
		int tmp16 = (grid_y * (int)128);		HX_STACK_VAR(tmp16,"tmp16");
		HX_STACK_LINE(50)
		int tmp17 = ::flixel::FlxG_obj::height;		HX_STACK_VAR(tmp17,"tmp17");
		HX_STACK_LINE(50)
		int tmp18 = (tmp16 + tmp17);		HX_STACK_VAR(tmp18,"tmp18");
		HX_STACK_LINE(50)
		int tmp19 = (tmp18 - (int)512);		HX_STACK_VAR(tmp19,"tmp19");
		HX_STACK_LINE(50)
		block->set_y(tmp19);
		HX_STACK_LINE(52)
		::MainState tmp20 = this->state;		HX_STACK_VAR(tmp20,"tmp20");
		HX_STACK_LINE(52)
		int tmp21 = grid_x;		HX_STACK_VAR(tmp21,"tmp21");
		HX_STACK_LINE(52)
		int tmp22 = grid_y;		HX_STACK_VAR(tmp22,"tmp22");
		HX_STACK_LINE(52)
		::PlacedWaystone tmp23 = block;		HX_STACK_VAR(tmp23,"tmp23");
		HX_STACK_LINE(52)
		bool tmp24 = tmp20->isValidPlacement(tmp21,tmp22,tmp23);		HX_STACK_VAR(tmp24,"tmp24");
		HX_STACK_LINE(52)
		if ((tmp24)){
			HX_STACK_LINE(53)
			::MainState tmp25 = this->state;		HX_STACK_VAR(tmp25,"tmp25");
			HX_STACK_LINE(53)
			::PlacedWaystone tmp26 = block;		HX_STACK_VAR(tmp26,"tmp26");
			HX_STACK_LINE(53)
			tmp25->place(tmp26);
			HX_STACK_LINE(54)
			::MainState tmp27 = this->state;		HX_STACK_VAR(tmp27,"tmp27");
			HX_STACK_LINE(54)
			::PlacedWaystone tmp28 = block;		HX_STACK_VAR(tmp28,"tmp28");
			HX_STACK_LINE(54)
			tmp27->z4->remove(tmp28,null());
			HX_STACK_LINE(55)
			::MainState tmp29 = this->state;		HX_STACK_VAR(tmp29,"tmp29");
			HX_STACK_LINE(55)
			::PlacedWaystone tmp30 = block;		HX_STACK_VAR(tmp30,"tmp30");
			HX_STACK_LINE(55)
			tmp29->z1->add(tmp30);
		}
		else{
			HX_STACK_LINE(57)
			::MainState tmp25 = this->state;		HX_STACK_VAR(tmp25,"tmp25");
			HX_STACK_LINE(57)
			::PlacedWaystone tmp26 = block;		HX_STACK_VAR(tmp26,"tmp26");
			HX_STACK_LINE(57)
			tmp25->z1->remove(tmp26,null());
			HX_STACK_LINE(58)
			block->kill();
		}
		HX_STACK_LINE(60)
		::MainState tmp25 = this->state;		HX_STACK_VAR(tmp25,"tmp25");
		HX_STACK_LINE(60)
		tmp25->sprite_following_mouse = null();
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC1(PlacedWaystone_obj,onMouseUp,(void))


PlacedWaystone_obj::PlacedWaystone_obj()
{
}

void PlacedWaystone_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(PlacedWaystone);
	HX_MARK_MEMBER_NAME(state,"state");
	HX_MARK_MEMBER_NAME(stone_properties,"stone_properties");
	HX_MARK_MEMBER_NAME(name,"name");
	HX_MARK_MEMBER_NAME(shape,"shape");
	::flixel::FlxSprite_obj::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

void PlacedWaystone_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(state,"state");
	HX_VISIT_MEMBER_NAME(stone_properties,"stone_properties");
	HX_VISIT_MEMBER_NAME(name,"name");
	HX_VISIT_MEMBER_NAME(shape,"shape");
	::flixel::FlxSprite_obj::__Visit(HX_VISIT_ARG);
}

Dynamic PlacedWaystone_obj::__Field(const ::String &inName,hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"name") ) { return name; }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"state") ) { return state; }
		if (HX_FIELD_EQ(inName,"shape") ) { return shape; }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"onMouseUp") ) { return onMouseUp_dyn(); }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"onMouseDown") ) { return onMouseDown_dyn(); }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"stone_properties") ) { return stone_properties; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic PlacedWaystone_obj::__SetField(const ::String &inName,const Dynamic &inValue,hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"name") ) { name=inValue.Cast< ::String >(); return inValue; }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"state") ) { state=inValue.Cast< ::MainState >(); return inValue; }
		if (HX_FIELD_EQ(inName,"shape") ) { shape=inValue.Cast< ::String >(); return inValue; }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"stone_properties") ) { stone_properties=inValue.Cast< Array< ::String > >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void PlacedWaystone_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_HCSTRING("state","\x11","\x76","\x0b","\x84"));
	outFields->push(HX_HCSTRING("stone_properties","\xcd","\xf8","\xa2","\x82"));
	outFields->push(HX_HCSTRING("name","\x4b","\x72","\xff","\x48"));
	outFields->push(HX_HCSTRING("shape","\x21","\xe3","\x1c","\x7c"));
	super::__GetFields(outFields);
};

#if HXCPP_SCRIPTABLE
static hx::StorageInfo sMemberStorageInfo[] = {
	{hx::fsObject /*::MainState*/ ,(int)offsetof(PlacedWaystone_obj,state),HX_HCSTRING("state","\x11","\x76","\x0b","\x84")},
	{hx::fsObject /*Array< ::String >*/ ,(int)offsetof(PlacedWaystone_obj,stone_properties),HX_HCSTRING("stone_properties","\xcd","\xf8","\xa2","\x82")},
	{hx::fsString,(int)offsetof(PlacedWaystone_obj,name),HX_HCSTRING("name","\x4b","\x72","\xff","\x48")},
	{hx::fsString,(int)offsetof(PlacedWaystone_obj,shape),HX_HCSTRING("shape","\x21","\xe3","\x1c","\x7c")},
	{ hx::fsUnknown, 0, null()}
};
static hx::StaticInfo *sStaticStorageInfo = 0;
#endif

static ::String sMemberFields[] = {
	HX_HCSTRING("state","\x11","\x76","\x0b","\x84"),
	HX_HCSTRING("stone_properties","\xcd","\xf8","\xa2","\x82"),
	HX_HCSTRING("name","\x4b","\x72","\xff","\x48"),
	HX_HCSTRING("shape","\x21","\xe3","\x1c","\x7c"),
	HX_HCSTRING("onMouseDown","\x08","\x94","\x05","\x11"),
	HX_HCSTRING("onMouseUp","\x81","\xac","\x1d","\x98"),
	::String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(PlacedWaystone_obj::__mClass,"__mClass");
};

#ifdef HXCPP_VISIT_ALLOCS
static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(PlacedWaystone_obj::__mClass,"__mClass");
};

#endif

hx::Class PlacedWaystone_obj::__mClass;

void PlacedWaystone_obj::__register()
{
	hx::Static(__mClass) = new hx::Class_obj();
	__mClass->mName = HX_HCSTRING("PlacedWaystone","\xd3","\xd3","\xa4","\x5d");
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &hx::Class_obj::GetNoStaticField;
	__mClass->mSetStaticField = &hx::Class_obj::SetNoStaticField;
	__mClass->mMarkFunc = sMarkStatics;
	__mClass->mStatics = hx::Class_obj::dupFunctions(0 /* sStaticFields */);
	__mClass->mMembers = hx::Class_obj::dupFunctions(sMemberFields);
	__mClass->mCanCast = hx::TCanCast< PlacedWaystone_obj >;
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

