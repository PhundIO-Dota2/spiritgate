#include <hxcpp.h>

#include "hxMath.h"
#ifndef INCLUDED_DraggableWaystone
#include <DraggableWaystone.h>
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

Void DraggableWaystone_obj::__construct(hx::Null< Float >  __o_X,hx::Null< Float >  __o_Y,::MainState state,::String shape,Array< ::String > stone_properties,::String name)
{
HX_STACK_FRAME("DraggableWaystone","new",0xf8591155,"DraggableWaystone.new","DraggableWaystone.hx",19,0x76352fbb)
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
	this->stone_properties = Array_obj< ::String >::__new();
	HX_STACK_LINE(29)
	Float tmp = X;		HX_STACK_VAR(tmp,"tmp");
	HX_STACK_LINE(29)
	Float tmp1 = Y;		HX_STACK_VAR(tmp1,"tmp1");
	HX_STACK_LINE(29)
	super::__construct(tmp,tmp1,null());
	HX_STACK_LINE(30)
	this->originX = X;
	HX_STACK_LINE(31)
	this->originY = Y;
	HX_STACK_LINE(32)
	this->shape = shape;
	HX_STACK_LINE(33)
	::String tmp2 = (HX_HCSTRING("assets/images/","\xab","\x47","\xcb","\x9f") + shape);		HX_STACK_VAR(tmp2,"tmp2");
	HX_STACK_LINE(33)
	::String tmp3 = (tmp2 + HX_HCSTRING(".png","\x3b","\x2d","\xbd","\x1e"));		HX_STACK_VAR(tmp3,"tmp3");
	HX_STACK_LINE(33)
	this->graphicPath = tmp3;
	HX_STACK_LINE(34)
	::String tmp4 = this->graphicPath;		HX_STACK_VAR(tmp4,"tmp4");
	HX_STACK_LINE(34)
	this->loadGraphic(tmp4,null(),null(),null(),null(),null());
	HX_STACK_LINE(35)
	::flixel::util::FlxPoint tmp5 = this->origin;		HX_STACK_VAR(tmp5,"tmp5");
	HX_STACK_LINE(35)
	tmp5->set((int)0,(int)0);
	HX_STACK_LINE(36)
	::flixel::util::FlxPoint tmp6 = this->scale;		HX_STACK_VAR(tmp6,"tmp6");
	HX_STACK_LINE(36)
	int tmp7 = this->frameWidth;		HX_STACK_VAR(tmp7,"tmp7");
	HX_STACK_LINE(36)
	Float tmp8 = (Float(((Float)72.0)) / Float(tmp7));		HX_STACK_VAR(tmp8,"tmp8");
	HX_STACK_LINE(36)
	int tmp9 = this->frameHeight;		HX_STACK_VAR(tmp9,"tmp9");
	HX_STACK_LINE(36)
	Float tmp10 = (Float(((Float)72.0)) / Float(tmp9));		HX_STACK_VAR(tmp10,"tmp10");
	HX_STACK_LINE(36)
	tmp6->set(tmp8,tmp10);
	HX_STACK_LINE(37)
	this->updateHitbox();
	HX_STACK_LINE(38)
	this->state = state;
	HX_STACK_LINE(39)
	state->z1->add(hx::ObjectPtr<OBJ_>(this));
	HX_STACK_LINE(40)
	this->name = name;
	HX_STACK_LINE(42)
	this->stone_properties = stone_properties;
}
;
	return null();
}

//DraggableWaystone_obj::~DraggableWaystone_obj() { }

Dynamic DraggableWaystone_obj::__CreateEmpty() { return  new DraggableWaystone_obj; }
hx::ObjectPtr< DraggableWaystone_obj > DraggableWaystone_obj::__new(hx::Null< Float >  __o_X,hx::Null< Float >  __o_Y,::MainState state,::String shape,Array< ::String > stone_properties,::String name)
{  hx::ObjectPtr< DraggableWaystone_obj > _result_ = new DraggableWaystone_obj();
	_result_->__construct(__o_X,__o_Y,state,shape,stone_properties,name);
	return _result_;}

Dynamic DraggableWaystone_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< DraggableWaystone_obj > _result_ = new DraggableWaystone_obj();
	_result_->__construct(inArgs[0],inArgs[1],inArgs[2],inArgs[3],inArgs[4],inArgs[5]);
	return _result_;}

Void DraggableWaystone_obj::onMouseDown( ::flixel::FlxSprite block){
{
		HX_STACK_FRAME("DraggableWaystone","onMouseDown",0x515451fd,"DraggableWaystone.onMouseDown","DraggableWaystone.hx",45,0x76352fbb)
		HX_STACK_THIS(this)
		HX_STACK_ARG(block,"block")
		HX_STACK_LINE(46)
		::MainState tmp = this->state;		HX_STACK_VAR(tmp,"tmp");
		HX_STACK_LINE(46)
		::flixel::FlxSprite tmp1 = tmp->sprite_following_mouse;		HX_STACK_VAR(tmp1,"tmp1");
		HX_STACK_LINE(46)
		bool tmp2 = (tmp1 == null());		HX_STACK_VAR(tmp2,"tmp2");
		HX_STACK_LINE(46)
		if ((tmp2)){
			HX_STACK_LINE(47)
			::flixel::FlxSprite tmp3 = ::flixel::FlxSprite_obj::__new(block->x,block->y,null());		HX_STACK_VAR(tmp3,"tmp3");
			HX_STACK_LINE(47)
			::flixel::FlxSprite standinBlock = tmp3;		HX_STACK_VAR(standinBlock,"standinBlock");
			HX_STACK_LINE(48)
			::String tmp4 = this->graphicPath;		HX_STACK_VAR(tmp4,"tmp4");
			HX_STACK_LINE(48)
			standinBlock->loadGraphic(tmp4,null(),null(),null(),null(),null());
			HX_STACK_LINE(49)
			Float tmp5 = (Float(((Float)72.0)) / Float(block->frameWidth));		HX_STACK_VAR(tmp5,"tmp5");
			HX_STACK_LINE(49)
			Float tmp6 = (Float(((Float)72.0)) / Float(block->frameHeight));		HX_STACK_VAR(tmp6,"tmp6");
			HX_STACK_LINE(49)
			standinBlock->scale->set(tmp5,tmp6);
			HX_STACK_LINE(50)
			standinBlock->set_alpha(((Float)0.5));
			HX_STACK_LINE(51)
			standinBlock->origin->set((int)0,(int)0);
			HX_STACK_LINE(52)
			::MainState tmp7 = this->state;		HX_STACK_VAR(tmp7,"tmp7");
			HX_STACK_LINE(52)
			::flixel::FlxSprite tmp8 = standinBlock;		HX_STACK_VAR(tmp8,"tmp8");
			HX_STACK_LINE(52)
			tmp7->add(tmp8);
			HX_STACK_LINE(53)
			this->standinBlock = standinBlock;
			HX_STACK_LINE(55)
			::MainState tmp9 = this->state;		HX_STACK_VAR(tmp9,"tmp9");
			HX_STACK_LINE(55)
			::flixel::FlxSprite tmp10 = block;		HX_STACK_VAR(tmp10,"tmp10");
			HX_STACK_LINE(55)
			tmp9->z1->remove(tmp10,null());
			HX_STACK_LINE(56)
			::MainState tmp11 = this->state;		HX_STACK_VAR(tmp11,"tmp11");
			HX_STACK_LINE(56)
			::flixel::FlxSprite tmp12 = block;		HX_STACK_VAR(tmp12,"tmp12");
			HX_STACK_LINE(56)
			tmp11->z4->add(tmp12);
			HX_STACK_LINE(57)
			::MainState tmp13 = this->state;		HX_STACK_VAR(tmp13,"tmp13");
			HX_STACK_LINE(57)
			tmp13->sprite_following_mouse = block;
			HX_STACK_LINE(58)
			::MainState tmp14 = this->state;		HX_STACK_VAR(tmp14,"tmp14");
			HX_STACK_LINE(58)
			::flixel::util::FlxPoint tmp15 = tmp14->sprite_following_mouse->scale;		HX_STACK_VAR(tmp15,"tmp15");
			HX_STACK_LINE(58)
			tmp15->set((int)1,(int)1);
			HX_STACK_LINE(59)
			block->updateHitbox();
		}
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC1(DraggableWaystone_obj,onMouseDown,(void))

Void DraggableWaystone_obj::onMouseUp( ::flixel::FlxSprite block){
{
		HX_STACK_FRAME("DraggableWaystone","onMouseUp",0x0b9d9336,"DraggableWaystone.onMouseUp","DraggableWaystone.hx",62,0x76352fbb)
		HX_STACK_THIS(this)
		HX_STACK_ARG(block,"block")
		HX_STACK_LINE(63)
		::flixel::FlxSprite tmp = this->standinBlock;		HX_STACK_VAR(tmp,"tmp");
		HX_STACK_LINE(63)
		bool tmp1 = (tmp != null());		HX_STACK_VAR(tmp1,"tmp1");
		HX_STACK_LINE(63)
		if ((tmp1)){
			HX_STACK_LINE(64)
			Float tmp2 = block->x;		HX_STACK_VAR(tmp2,"tmp2");
			HX_STACK_LINE(64)
			int tmp3 = ::flixel::FlxG_obj::width;		HX_STACK_VAR(tmp3,"tmp3");
			HX_STACK_LINE(64)
			Float tmp4 = (tmp2 - tmp3);		HX_STACK_VAR(tmp4,"tmp4");
			HX_STACK_LINE(64)
			Float tmp5 = (tmp4 + (int)512);		HX_STACK_VAR(tmp5,"tmp5");
			HX_STACK_LINE(64)
			Float tmp6 = (Float(tmp5) / Float((int)128));		HX_STACK_VAR(tmp6,"tmp6");
			HX_STACK_LINE(64)
			int tmp7 = ::Math_obj::round(tmp6);		HX_STACK_VAR(tmp7,"tmp7");
			HX_STACK_LINE(64)
			int grid_x = tmp7;		HX_STACK_VAR(grid_x,"grid_x");
			HX_STACK_LINE(65)
			Float tmp8 = block->y;		HX_STACK_VAR(tmp8,"tmp8");
			HX_STACK_LINE(65)
			int tmp9 = ::flixel::FlxG_obj::height;		HX_STACK_VAR(tmp9,"tmp9");
			HX_STACK_LINE(65)
			Float tmp10 = (tmp8 - tmp9);		HX_STACK_VAR(tmp10,"tmp10");
			HX_STACK_LINE(65)
			Float tmp11 = (tmp10 + (int)512);		HX_STACK_VAR(tmp11,"tmp11");
			HX_STACK_LINE(65)
			Float tmp12 = (Float(tmp11) / Float((int)128));		HX_STACK_VAR(tmp12,"tmp12");
			HX_STACK_LINE(65)
			int tmp13 = ::Math_obj::round(tmp12);		HX_STACK_VAR(tmp13,"tmp13");
			HX_STACK_LINE(65)
			int grid_y = tmp13;		HX_STACK_VAR(grid_y,"grid_y");
			HX_STACK_LINE(66)
			int tmp14 = (grid_x * (int)128);		HX_STACK_VAR(tmp14,"tmp14");
			HX_STACK_LINE(66)
			int tmp15 = ::flixel::FlxG_obj::width;		HX_STACK_VAR(tmp15,"tmp15");
			HX_STACK_LINE(66)
			int tmp16 = (tmp14 + tmp15);		HX_STACK_VAR(tmp16,"tmp16");
			HX_STACK_LINE(66)
			int tmp17 = (tmp16 - (int)512);		HX_STACK_VAR(tmp17,"tmp17");
			HX_STACK_LINE(66)
			int tmp18 = (grid_y * (int)128);		HX_STACK_VAR(tmp18,"tmp18");
			HX_STACK_LINE(66)
			int tmp19 = ::flixel::FlxG_obj::height;		HX_STACK_VAR(tmp19,"tmp19");
			HX_STACK_LINE(66)
			int tmp20 = (tmp18 + tmp19);		HX_STACK_VAR(tmp20,"tmp20");
			HX_STACK_LINE(66)
			int tmp21 = (tmp20 - (int)512);		HX_STACK_VAR(tmp21,"tmp21");
			HX_STACK_LINE(66)
			::MainState tmp22 = this->state;		HX_STACK_VAR(tmp22,"tmp22");
			HX_STACK_LINE(66)
			::String tmp23 = this->shape;		HX_STACK_VAR(tmp23,"tmp23");
			HX_STACK_LINE(66)
			::String tmp24 = this->name;		HX_STACK_VAR(tmp24,"tmp24");
			HX_STACK_LINE(66)
			::PlacedWaystone tmp25 = ::PlacedWaystone_obj::__new(tmp17,tmp21,tmp22,tmp23,this->stone_properties,tmp24);		HX_STACK_VAR(tmp25,"tmp25");
			HX_STACK_LINE(66)
			::PlacedWaystone placedStone = tmp25;		HX_STACK_VAR(placedStone,"placedStone");
			HX_STACK_LINE(67)
			Float tmp26 = block->angle;		HX_STACK_VAR(tmp26,"tmp26");
			HX_STACK_LINE(67)
			placedStone->set_angle(tmp26);
			HX_STACK_LINE(68)
			placedStone->dirty = true;
			HX_STACK_LINE(69)
			placedStone->updateHitbox();
			HX_STACK_LINE(70)
			::MainState tmp27 = this->state;		HX_STACK_VAR(tmp27,"tmp27");
			HX_STACK_LINE(70)
			int tmp28 = grid_x;		HX_STACK_VAR(tmp28,"tmp28");
			HX_STACK_LINE(70)
			int tmp29 = grid_y;		HX_STACK_VAR(tmp29,"tmp29");
			HX_STACK_LINE(70)
			::PlacedWaystone tmp30 = placedStone;		HX_STACK_VAR(tmp30,"tmp30");
			HX_STACK_LINE(70)
			bool tmp31 = tmp27->isValidPlacement(tmp28,tmp29,tmp30);		HX_STACK_VAR(tmp31,"tmp31");
			HX_STACK_LINE(70)
			if ((tmp31)){
				HX_STACK_LINE(71)
				::MainState tmp32 = this->state;		HX_STACK_VAR(tmp32,"tmp32");
				HX_STACK_LINE(71)
				::PlacedWaystone tmp33 = placedStone;		HX_STACK_VAR(tmp33,"tmp33");
				HX_STACK_LINE(71)
				tmp32->place(tmp33);
			}
			else{
				HX_STACK_LINE(73)
				::MainState tmp32 = this->state;		HX_STACK_VAR(tmp32,"tmp32");
				HX_STACK_LINE(73)
				::PlacedWaystone tmp33 = placedStone;		HX_STACK_VAR(tmp33,"tmp33");
				HX_STACK_LINE(73)
				tmp32->z1->remove(tmp33,null());
			}
			HX_STACK_LINE(75)
			block->set_angle((int)0);
			HX_STACK_LINE(77)
			::MainState tmp32 = this->state;		HX_STACK_VAR(tmp32,"tmp32");
			HX_STACK_LINE(77)
			::flixel::FlxSprite tmp33 = block;		HX_STACK_VAR(tmp33,"tmp33");
			HX_STACK_LINE(77)
			tmp32->z4->remove(tmp33,null());
			HX_STACK_LINE(78)
			::MainState tmp34 = this->state;		HX_STACK_VAR(tmp34,"tmp34");
			HX_STACK_LINE(78)
			::flixel::FlxSprite tmp35 = block;		HX_STACK_VAR(tmp35,"tmp35");
			HX_STACK_LINE(78)
			tmp34->z1->add(tmp35);
			HX_STACK_LINE(79)
			::flixel::FlxSprite tmp36 = this->standinBlock;		HX_STACK_VAR(tmp36,"tmp36");
			HX_STACK_LINE(79)
			Float tmp37 = tmp36->x;		HX_STACK_VAR(tmp37,"tmp37");
			HX_STACK_LINE(79)
			block->set_x(tmp37);
			HX_STACK_LINE(80)
			::flixel::FlxSprite tmp38 = this->standinBlock;		HX_STACK_VAR(tmp38,"tmp38");
			HX_STACK_LINE(80)
			Float tmp39 = tmp38->y;		HX_STACK_VAR(tmp39,"tmp39");
			HX_STACK_LINE(80)
			block->set_y(tmp39);
			HX_STACK_LINE(81)
			::flixel::FlxSprite tmp40 = this->standinBlock;		HX_STACK_VAR(tmp40,"tmp40");
			HX_STACK_LINE(81)
			tmp40->kill();
			HX_STACK_LINE(82)
			Float tmp41 = (Float(((Float)72.0)) / Float(block->frameWidth));		HX_STACK_VAR(tmp41,"tmp41");
			HX_STACK_LINE(82)
			Float tmp42 = (Float(((Float)72.0)) / Float(block->frameHeight));		HX_STACK_VAR(tmp42,"tmp42");
			HX_STACK_LINE(82)
			block->scale->set(tmp41,tmp42);
			HX_STACK_LINE(83)
			block->updateHitbox();
			HX_STACK_LINE(84)
			::MainState tmp43 = this->state;		HX_STACK_VAR(tmp43,"tmp43");
			HX_STACK_LINE(84)
			tmp43->sprite_following_mouse = null();
		}
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC1(DraggableWaystone_obj,onMouseUp,(void))


DraggableWaystone_obj::DraggableWaystone_obj()
{
}

void DraggableWaystone_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(DraggableWaystone);
	HX_MARK_MEMBER_NAME(originX,"originX");
	HX_MARK_MEMBER_NAME(originY,"originY");
	HX_MARK_MEMBER_NAME(graphicPath,"graphicPath");
	HX_MARK_MEMBER_NAME(shape,"shape");
	HX_MARK_MEMBER_NAME(state,"state");
	HX_MARK_MEMBER_NAME(standinBlock,"standinBlock");
	HX_MARK_MEMBER_NAME(stone_properties,"stone_properties");
	HX_MARK_MEMBER_NAME(name,"name");
	::flixel::FlxSprite_obj::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

void DraggableWaystone_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(originX,"originX");
	HX_VISIT_MEMBER_NAME(originY,"originY");
	HX_VISIT_MEMBER_NAME(graphicPath,"graphicPath");
	HX_VISIT_MEMBER_NAME(shape,"shape");
	HX_VISIT_MEMBER_NAME(state,"state");
	HX_VISIT_MEMBER_NAME(standinBlock,"standinBlock");
	HX_VISIT_MEMBER_NAME(stone_properties,"stone_properties");
	HX_VISIT_MEMBER_NAME(name,"name");
	::flixel::FlxSprite_obj::__Visit(HX_VISIT_ARG);
}

Dynamic DraggableWaystone_obj::__Field(const ::String &inName,hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"name") ) { return name; }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"shape") ) { return shape; }
		if (HX_FIELD_EQ(inName,"state") ) { return state; }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"originX") ) { return originX; }
		if (HX_FIELD_EQ(inName,"originY") ) { return originY; }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"onMouseUp") ) { return onMouseUp_dyn(); }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"graphicPath") ) { return graphicPath; }
		if (HX_FIELD_EQ(inName,"onMouseDown") ) { return onMouseDown_dyn(); }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"standinBlock") ) { return standinBlock; }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"stone_properties") ) { return stone_properties; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic DraggableWaystone_obj::__SetField(const ::String &inName,const Dynamic &inValue,hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"name") ) { name=inValue.Cast< ::String >(); return inValue; }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"shape") ) { shape=inValue.Cast< ::String >(); return inValue; }
		if (HX_FIELD_EQ(inName,"state") ) { state=inValue.Cast< ::MainState >(); return inValue; }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"originX") ) { originX=inValue.Cast< Float >(); return inValue; }
		if (HX_FIELD_EQ(inName,"originY") ) { originY=inValue.Cast< Float >(); return inValue; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"graphicPath") ) { graphicPath=inValue.Cast< ::String >(); return inValue; }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"standinBlock") ) { standinBlock=inValue.Cast< ::flixel::FlxSprite >(); return inValue; }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"stone_properties") ) { stone_properties=inValue.Cast< Array< ::String > >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void DraggableWaystone_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_HCSTRING("originX","\xb2","\x8f","\xf5","\x55"));
	outFields->push(HX_HCSTRING("originY","\xb3","\x8f","\xf5","\x55"));
	outFields->push(HX_HCSTRING("graphicPath","\x6d","\xe0","\x38","\x84"));
	outFields->push(HX_HCSTRING("shape","\x21","\xe3","\x1c","\x7c"));
	outFields->push(HX_HCSTRING("state","\x11","\x76","\x0b","\x84"));
	outFields->push(HX_HCSTRING("standinBlock","\x12","\x41","\x27","\x17"));
	outFields->push(HX_HCSTRING("stone_properties","\xcd","\xf8","\xa2","\x82"));
	outFields->push(HX_HCSTRING("name","\x4b","\x72","\xff","\x48"));
	super::__GetFields(outFields);
};

#if HXCPP_SCRIPTABLE
static hx::StorageInfo sMemberStorageInfo[] = {
	{hx::fsFloat,(int)offsetof(DraggableWaystone_obj,originX),HX_HCSTRING("originX","\xb2","\x8f","\xf5","\x55")},
	{hx::fsFloat,(int)offsetof(DraggableWaystone_obj,originY),HX_HCSTRING("originY","\xb3","\x8f","\xf5","\x55")},
	{hx::fsString,(int)offsetof(DraggableWaystone_obj,graphicPath),HX_HCSTRING("graphicPath","\x6d","\xe0","\x38","\x84")},
	{hx::fsString,(int)offsetof(DraggableWaystone_obj,shape),HX_HCSTRING("shape","\x21","\xe3","\x1c","\x7c")},
	{hx::fsObject /*::MainState*/ ,(int)offsetof(DraggableWaystone_obj,state),HX_HCSTRING("state","\x11","\x76","\x0b","\x84")},
	{hx::fsObject /*::flixel::FlxSprite*/ ,(int)offsetof(DraggableWaystone_obj,standinBlock),HX_HCSTRING("standinBlock","\x12","\x41","\x27","\x17")},
	{hx::fsObject /*Array< ::String >*/ ,(int)offsetof(DraggableWaystone_obj,stone_properties),HX_HCSTRING("stone_properties","\xcd","\xf8","\xa2","\x82")},
	{hx::fsString,(int)offsetof(DraggableWaystone_obj,name),HX_HCSTRING("name","\x4b","\x72","\xff","\x48")},
	{ hx::fsUnknown, 0, null()}
};
static hx::StaticInfo *sStaticStorageInfo = 0;
#endif

static ::String sMemberFields[] = {
	HX_HCSTRING("originX","\xb2","\x8f","\xf5","\x55"),
	HX_HCSTRING("originY","\xb3","\x8f","\xf5","\x55"),
	HX_HCSTRING("graphicPath","\x6d","\xe0","\x38","\x84"),
	HX_HCSTRING("shape","\x21","\xe3","\x1c","\x7c"),
	HX_HCSTRING("state","\x11","\x76","\x0b","\x84"),
	HX_HCSTRING("standinBlock","\x12","\x41","\x27","\x17"),
	HX_HCSTRING("stone_properties","\xcd","\xf8","\xa2","\x82"),
	HX_HCSTRING("name","\x4b","\x72","\xff","\x48"),
	HX_HCSTRING("onMouseDown","\x08","\x94","\x05","\x11"),
	HX_HCSTRING("onMouseUp","\x81","\xac","\x1d","\x98"),
	::String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(DraggableWaystone_obj::__mClass,"__mClass");
};

#ifdef HXCPP_VISIT_ALLOCS
static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(DraggableWaystone_obj::__mClass,"__mClass");
};

#endif

hx::Class DraggableWaystone_obj::__mClass;

void DraggableWaystone_obj::__register()
{
	hx::Static(__mClass) = new hx::Class_obj();
	__mClass->mName = HX_HCSTRING("DraggableWaystone","\xe3","\xc2","\x1e","\x02");
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &hx::Class_obj::GetNoStaticField;
	__mClass->mSetStaticField = &hx::Class_obj::SetNoStaticField;
	__mClass->mMarkFunc = sMarkStatics;
	__mClass->mStatics = hx::Class_obj::dupFunctions(0 /* sStaticFields */);
	__mClass->mMembers = hx::Class_obj::dupFunctions(sMemberFields);
	__mClass->mCanCast = hx::TCanCast< DraggableWaystone_obj >;
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

