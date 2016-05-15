#include <hxcpp.h>

#include "hxMath.h"
#ifndef INCLUDED_Std
#include <Std.h>
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
#ifndef INCLUDED_flixel_FlxGame
#include <flixel/FlxGame.h>
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
#ifndef INCLUDED_flixel_input_touch_FlxTouch
#include <flixel/input/touch/FlxTouch.h>
#endif
#ifndef INCLUDED_flixel_input_touch_FlxTouchManager
#include <flixel/input/touch/FlxTouchManager.h>
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
#ifndef INCLUDED_flixel_plugin_FlxPlugin
#include <flixel/plugin/FlxPlugin.h>
#endif
#ifndef INCLUDED_flixel_plugin_MouseEventManager
#include <flixel/plugin/MouseEventManager.h>
#endif
#ifndef INCLUDED_flixel_plugin__MouseEventManager_ObjectMouseData
#include <flixel/plugin/_MouseEventManager/ObjectMouseData.h>
#endif
#ifndef INCLUDED_flixel_system_frontEnds_PluginFrontEnd
#include <flixel/system/frontEnds/PluginFrontEnd.h>
#endif
#ifndef INCLUDED_flixel_util_FlxDestroyUtil
#include <flixel/util/FlxDestroyUtil.h>
#endif
#ifndef INCLUDED_flixel_util_FlxPoint
#include <flixel/util/FlxPoint.h>
#endif
#ifndef INCLUDED_flixel_util_FlxPool
#include <flixel/util/FlxPool.h>
#endif
#ifndef INCLUDED_openfl__legacy_display_DisplayObject
#include <openfl/_legacy/display/DisplayObject.h>
#endif
#ifndef INCLUDED_openfl__legacy_display_DisplayObjectContainer
#include <openfl/_legacy/display/DisplayObjectContainer.h>
#endif
#ifndef INCLUDED_openfl__legacy_display_IBitmapDrawable
#include <openfl/_legacy/display/IBitmapDrawable.h>
#endif
#ifndef INCLUDED_openfl__legacy_display_InteractiveObject
#include <openfl/_legacy/display/InteractiveObject.h>
#endif
#ifndef INCLUDED_openfl__legacy_display_Sprite
#include <openfl/_legacy/display/Sprite.h>
#endif
#ifndef INCLUDED_openfl__legacy_events_EventDispatcher
#include <openfl/_legacy/events/EventDispatcher.h>
#endif
#ifndef INCLUDED_openfl__legacy_events_IEventDispatcher
#include <openfl/_legacy/events/IEventDispatcher.h>
#endif
#ifndef INCLUDED_openfl_errors_Error
#include <openfl/errors/Error.h>
#endif
namespace flixel{
namespace plugin{

Void MouseEventManager_obj::__construct()
{
HX_STACK_FRAME("flixel.plugin.MouseEventManager","new",0x1e64e761,"flixel.plugin.MouseEventManager.new","flixel/plugin/MouseEventManager.hx",281,0x4767214f)
HX_STACK_THIS(this)
{
	HX_STACK_LINE(282)
	super::__construct();
	HX_STACK_LINE(284)
	::flixel::util::FlxPoint tmp;		HX_STACK_VAR(tmp,"tmp");
	HX_STACK_LINE(284)
	{
		HX_STACK_LINE(284)
		Float X = (int)0;		HX_STACK_VAR(X,"X");
		HX_STACK_LINE(284)
		Float Y = (int)0;		HX_STACK_VAR(Y,"Y");
		HX_STACK_LINE(284)
		::flixel::util::FlxPool tmp1 = ::flixel::util::FlxPoint_obj::_pool;		HX_STACK_VAR(tmp1,"tmp1");
		HX_STACK_LINE(284)
		::flixel::util::FlxPoint tmp2 = tmp1->get();		HX_STACK_VAR(tmp2,"tmp2");
		HX_STACK_LINE(284)
		Float tmp3 = X;		HX_STACK_VAR(tmp3,"tmp3");
		HX_STACK_LINE(284)
		Float tmp4 = Y;		HX_STACK_VAR(tmp4,"tmp4");
		HX_STACK_LINE(284)
		::flixel::util::FlxPoint tmp5 = tmp2->set(tmp3,tmp4);		HX_STACK_VAR(tmp5,"tmp5");
		HX_STACK_LINE(284)
		::flixel::util::FlxPoint point = tmp5;		HX_STACK_VAR(point,"point");
		HX_STACK_LINE(284)
		point->_inPool = false;
		HX_STACK_LINE(284)
		tmp = point;
	}
	HX_STACK_LINE(284)
	::flixel::plugin::MouseEventManager_obj::_point = tmp;
	HX_STACK_LINE(286)
	bool tmp1 = (::flixel::plugin::MouseEventManager_obj::_registeredObjects != null());		HX_STACK_VAR(tmp1,"tmp1");
	HX_STACK_LINE(286)
	if ((tmp1)){
		HX_STACK_LINE(288)
		this->clearRegistry();
	}
	HX_STACK_LINE(291)
	::flixel::plugin::MouseEventManager_obj::_registeredObjects = Array_obj< ::Dynamic >::__new();
	HX_STACK_LINE(292)
	::flixel::plugin::MouseEventManager_obj::_mouseOverObjects = Array_obj< ::Dynamic >::__new();
}
;
	return null();
}

//MouseEventManager_obj::~MouseEventManager_obj() { }

Dynamic MouseEventManager_obj::__CreateEmpty() { return  new MouseEventManager_obj; }
hx::ObjectPtr< MouseEventManager_obj > MouseEventManager_obj::__new()
{  hx::ObjectPtr< MouseEventManager_obj > _result_ = new MouseEventManager_obj();
	_result_->__construct();
	return _result_;}

Dynamic MouseEventManager_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< MouseEventManager_obj > _result_ = new MouseEventManager_obj();
	_result_->__construct();
	return _result_;}

Void MouseEventManager_obj::destroy( ){
{
		HX_STACK_FRAME("flixel.plugin.MouseEventManager","destroy",0xe9d5587b,"flixel.plugin.MouseEventManager.destroy","flixel/plugin/MouseEventManager.hx",296,0x4767214f)
		HX_STACK_THIS(this)
		HX_STACK_LINE(297)
		this->clearRegistry();
		HX_STACK_LINE(298)
		::flixel::util::FlxPoint tmp = ::flixel::plugin::MouseEventManager_obj::_point;		HX_STACK_VAR(tmp,"tmp");
		HX_STACK_LINE(298)
		::flixel::util::FlxPoint tmp1 = ::flixel::util::FlxDestroyUtil_obj::put(tmp);		HX_STACK_VAR(tmp1,"tmp1");
		HX_STACK_LINE(298)
		::flixel::plugin::MouseEventManager_obj::_point = tmp1;
		HX_STACK_LINE(299)
		this->super::destroy();
	}
return null();
}


Void MouseEventManager_obj::update( ){
{
		HX_STACK_FRAME("flixel.plugin.MouseEventManager","update",0xfe2605a8,"flixel.plugin.MouseEventManager.update","flixel/plugin/MouseEventManager.hx",303,0x4767214f)
		HX_STACK_THIS(this)
		HX_STACK_LINE(304)
		this->super::update();
		HX_STACK_LINE(306)
		Array< ::Dynamic > currentOverObjects = Array_obj< ::Dynamic >::__new();		HX_STACK_VAR(currentOverObjects,"currentOverObjects");
		HX_STACK_LINE(308)
		{
			HX_STACK_LINE(308)
			int _g = (int)0;		HX_STACK_VAR(_g,"_g");
			HX_STACK_LINE(308)
			Array< ::Dynamic > _g1 = ::flixel::plugin::MouseEventManager_obj::_registeredObjects;		HX_STACK_VAR(_g1,"_g1");
			HX_STACK_LINE(308)
			while((true)){
				HX_STACK_LINE(308)
				bool tmp = (_g < _g1->length);		HX_STACK_VAR(tmp,"tmp");
				HX_STACK_LINE(308)
				bool tmp1 = !(tmp);		HX_STACK_VAR(tmp1,"tmp1");
				HX_STACK_LINE(308)
				if ((tmp1)){
					HX_STACK_LINE(308)
					break;
				}
				HX_STACK_LINE(308)
				::flixel::plugin::_MouseEventManager::ObjectMouseData tmp2 = _g1->__get(_g).StaticCast< ::flixel::plugin::_MouseEventManager::ObjectMouseData >();		HX_STACK_VAR(tmp2,"tmp2");
				HX_STACK_LINE(308)
				::flixel::plugin::_MouseEventManager::ObjectMouseData reg = tmp2;		HX_STACK_VAR(reg,"reg");
				HX_STACK_LINE(308)
				++(_g);
				HX_STACK_LINE(311)
				::flixel::util::FlxPoint tmp3 = reg->object->acceleration;		HX_STACK_VAR(tmp3,"tmp3");
				HX_STACK_LINE(311)
				bool tmp4 = (tmp3 == null());		HX_STACK_VAR(tmp4,"tmp4");
				HX_STACK_LINE(311)
				if ((tmp4)){
					HX_STACK_LINE(313)
					::flixel::FlxObject tmp5 = reg->object;		HX_STACK_VAR(tmp5,"tmp5");
					HX_STACK_LINE(313)
					::flixel::plugin::MouseEventManager_obj::remove(tmp5);
					HX_STACK_LINE(314)
					continue;
				}
				HX_STACK_LINE(317)
				bool tmp5 = reg->object->alive;		HX_STACK_VAR(tmp5,"tmp5");
				HX_STACK_LINE(317)
				bool tmp6 = tmp5;		HX_STACK_VAR(tmp6,"tmp6");
				HX_STACK_LINE(317)
				bool tmp7 = !(tmp6);		HX_STACK_VAR(tmp7,"tmp7");
				HX_STACK_LINE(317)
				bool tmp8 = !(tmp7);		HX_STACK_VAR(tmp8,"tmp8");
				HX_STACK_LINE(317)
				bool tmp9 = tmp8;		HX_STACK_VAR(tmp9,"tmp9");
				HX_STACK_LINE(317)
				bool tmp10;		HX_STACK_VAR(tmp10,"tmp10");
				HX_STACK_LINE(317)
				if ((tmp9)){
					HX_STACK_LINE(317)
					bool tmp11 = reg->object->exists;		HX_STACK_VAR(tmp11,"tmp11");
					HX_STACK_LINE(317)
					bool tmp12 = tmp11;		HX_STACK_VAR(tmp12,"tmp12");
					HX_STACK_LINE(317)
					bool tmp13 = tmp12;		HX_STACK_VAR(tmp13,"tmp13");
					HX_STACK_LINE(317)
					bool tmp14 = tmp13;		HX_STACK_VAR(tmp14,"tmp14");
					HX_STACK_LINE(317)
					bool tmp15 = tmp14;		HX_STACK_VAR(tmp15,"tmp15");
					HX_STACK_LINE(317)
					tmp10 = !(tmp15);
				}
				else{
					HX_STACK_LINE(317)
					tmp10 = true;
				}
				HX_STACK_LINE(317)
				bool tmp11 = !(tmp10);		HX_STACK_VAR(tmp11,"tmp11");
				HX_STACK_LINE(317)
				bool tmp12 = tmp11;		HX_STACK_VAR(tmp12,"tmp12");
				HX_STACK_LINE(317)
				bool tmp13;		HX_STACK_VAR(tmp13,"tmp13");
				HX_STACK_LINE(317)
				if ((tmp12)){
					HX_STACK_LINE(317)
					bool tmp14 = reg->object->visible;		HX_STACK_VAR(tmp14,"tmp14");
					HX_STACK_LINE(317)
					bool tmp15 = tmp14;		HX_STACK_VAR(tmp15,"tmp15");
					HX_STACK_LINE(317)
					bool tmp16 = tmp15;		HX_STACK_VAR(tmp16,"tmp16");
					HX_STACK_LINE(317)
					bool tmp17 = tmp16;		HX_STACK_VAR(tmp17,"tmp17");
					HX_STACK_LINE(317)
					bool tmp18 = tmp17;		HX_STACK_VAR(tmp18,"tmp18");
					HX_STACK_LINE(317)
					tmp13 = !(tmp18);
				}
				else{
					HX_STACK_LINE(317)
					tmp13 = true;
				}
				HX_STACK_LINE(317)
				bool tmp14 = !(tmp13);		HX_STACK_VAR(tmp14,"tmp14");
				HX_STACK_LINE(317)
				bool tmp15;		HX_STACK_VAR(tmp15,"tmp15");
				HX_STACK_LINE(317)
				if ((tmp14)){
					HX_STACK_LINE(317)
					bool tmp16 = reg->mouseEnabled;		HX_STACK_VAR(tmp16,"tmp16");
					HX_STACK_LINE(317)
					bool tmp17 = tmp16;		HX_STACK_VAR(tmp17,"tmp17");
					HX_STACK_LINE(317)
					tmp15 = !(tmp17);
				}
				else{
					HX_STACK_LINE(317)
					tmp15 = true;
				}
				HX_STACK_LINE(317)
				if ((tmp15)){
					HX_STACK_LINE(319)
					continue;
				}
				HX_STACK_LINE(322)
				::flixel::plugin::_MouseEventManager::ObjectMouseData tmp16 = reg;		HX_STACK_VAR(tmp16,"tmp16");
				HX_STACK_LINE(322)
				bool tmp17 = this->checkOverlap(tmp16);		HX_STACK_VAR(tmp17,"tmp17");
				HX_STACK_LINE(322)
				if ((tmp17)){
					HX_STACK_LINE(324)
					::flixel::plugin::_MouseEventManager::ObjectMouseData tmp18 = reg;		HX_STACK_VAR(tmp18,"tmp18");
					HX_STACK_LINE(324)
					currentOverObjects->push(tmp18);
					HX_STACK_LINE(326)
					bool tmp19 = reg->mouseChildren;		HX_STACK_VAR(tmp19,"tmp19");
					HX_STACK_LINE(326)
					bool tmp20 = !(tmp19);		HX_STACK_VAR(tmp20,"tmp20");
					HX_STACK_LINE(326)
					if ((tmp20)){
						HX_STACK_LINE(328)
						break;
					}
				}
			}
		}
		HX_STACK_LINE(334)
		{
			HX_STACK_LINE(334)
			int _g = (int)0;		HX_STACK_VAR(_g,"_g");
			HX_STACK_LINE(334)
			while((true)){
				HX_STACK_LINE(334)
				bool tmp = (_g < currentOverObjects->length);		HX_STACK_VAR(tmp,"tmp");
				HX_STACK_LINE(334)
				bool tmp1 = !(tmp);		HX_STACK_VAR(tmp1,"tmp1");
				HX_STACK_LINE(334)
				if ((tmp1)){
					HX_STACK_LINE(334)
					break;
				}
				HX_STACK_LINE(334)
				::flixel::plugin::_MouseEventManager::ObjectMouseData tmp2 = currentOverObjects->__get(_g).StaticCast< ::flixel::plugin::_MouseEventManager::ObjectMouseData >();		HX_STACK_VAR(tmp2,"tmp2");
				HX_STACK_LINE(334)
				::flixel::plugin::_MouseEventManager::ObjectMouseData current = tmp2;		HX_STACK_VAR(current,"current");
				HX_STACK_LINE(334)
				++(_g);
				HX_STACK_LINE(336)
				bool tmp3 = (current->onMouseOver != null());		HX_STACK_VAR(tmp3,"tmp3");
				HX_STACK_LINE(336)
				if ((tmp3)){
					HX_STACK_LINE(338)
					bool tmp4 = current->object->exists;		HX_STACK_VAR(tmp4,"tmp4");
					HX_STACK_LINE(338)
					bool tmp5 = tmp4;		HX_STACK_VAR(tmp5,"tmp5");
					HX_STACK_LINE(338)
					bool tmp6;		HX_STACK_VAR(tmp6,"tmp6");
					HX_STACK_LINE(338)
					if ((tmp5)){
						HX_STACK_LINE(338)
						tmp6 = current->object->visible;
					}
					else{
						HX_STACK_LINE(338)
						tmp6 = false;
					}
					HX_STACK_LINE(338)
					bool tmp7;		HX_STACK_VAR(tmp7,"tmp7");
					HX_STACK_LINE(338)
					if ((tmp6)){
						HX_STACK_LINE(338)
						::flixel::FlxObject tmp8 = current->object;		HX_STACK_VAR(tmp8,"tmp8");
						HX_STACK_LINE(338)
						::flixel::FlxObject tmp9 = tmp8;		HX_STACK_VAR(tmp9,"tmp9");
						HX_STACK_LINE(338)
						::flixel::plugin::_MouseEventManager::ObjectMouseData tmp10 = ::flixel::plugin::MouseEventManager_obj::getRegister(tmp9,::flixel::plugin::MouseEventManager_obj::_mouseOverObjects);		HX_STACK_VAR(tmp10,"tmp10");
						HX_STACK_LINE(338)
						::flixel::plugin::_MouseEventManager::ObjectMouseData tmp11 = tmp10;		HX_STACK_VAR(tmp11,"tmp11");
						HX_STACK_LINE(338)
						tmp7 = (tmp11 == null());
					}
					else{
						HX_STACK_LINE(338)
						tmp7 = false;
					}
					HX_STACK_LINE(338)
					if ((tmp7)){
						HX_STACK_LINE(340)
						::flixel::FlxObject tmp8 = current->object;		HX_STACK_VAR(tmp8,"tmp8");
						HX_STACK_LINE(340)
						current->onMouseOver(tmp8);
					}
				}
			}
		}
		HX_STACK_LINE(346)
		{
			HX_STACK_LINE(346)
			int _g = (int)0;		HX_STACK_VAR(_g,"_g");
			HX_STACK_LINE(346)
			Array< ::Dynamic > _g1 = ::flixel::plugin::MouseEventManager_obj::_mouseOverObjects;		HX_STACK_VAR(_g1,"_g1");
			HX_STACK_LINE(346)
			while((true)){
				HX_STACK_LINE(346)
				bool tmp = (_g < _g1->length);		HX_STACK_VAR(tmp,"tmp");
				HX_STACK_LINE(346)
				bool tmp1 = !(tmp);		HX_STACK_VAR(tmp1,"tmp1");
				HX_STACK_LINE(346)
				if ((tmp1)){
					HX_STACK_LINE(346)
					break;
				}
				HX_STACK_LINE(346)
				::flixel::plugin::_MouseEventManager::ObjectMouseData tmp2 = _g1->__get(_g).StaticCast< ::flixel::plugin::_MouseEventManager::ObjectMouseData >();		HX_STACK_VAR(tmp2,"tmp2");
				HX_STACK_LINE(346)
				::flixel::plugin::_MouseEventManager::ObjectMouseData over = tmp2;		HX_STACK_VAR(over,"over");
				HX_STACK_LINE(346)
				++(_g);
				HX_STACK_LINE(348)
				bool tmp3 = (over->onMouseOut != null());		HX_STACK_VAR(tmp3,"tmp3");
				HX_STACK_LINE(348)
				if ((tmp3)){
					HX_STACK_LINE(351)
					bool tmp4 = over->object->exists;		HX_STACK_VAR(tmp4,"tmp4");
					HX_STACK_LINE(351)
					bool tmp5 = tmp4;		HX_STACK_VAR(tmp5,"tmp5");
					HX_STACK_LINE(351)
					bool tmp6 = !(tmp5);		HX_STACK_VAR(tmp6,"tmp6");
					HX_STACK_LINE(351)
					bool tmp7 = !(tmp6);		HX_STACK_VAR(tmp7,"tmp7");
					HX_STACK_LINE(351)
					bool tmp8 = tmp7;		HX_STACK_VAR(tmp8,"tmp8");
					HX_STACK_LINE(351)
					bool tmp9;		HX_STACK_VAR(tmp9,"tmp9");
					HX_STACK_LINE(351)
					if ((tmp8)){
						HX_STACK_LINE(351)
						bool tmp10 = over->object->visible;		HX_STACK_VAR(tmp10,"tmp10");
						HX_STACK_LINE(351)
						bool tmp11 = tmp10;		HX_STACK_VAR(tmp11,"tmp11");
						HX_STACK_LINE(351)
						bool tmp12 = tmp11;		HX_STACK_VAR(tmp12,"tmp12");
						HX_STACK_LINE(351)
						bool tmp13 = tmp12;		HX_STACK_VAR(tmp13,"tmp13");
						HX_STACK_LINE(351)
						bool tmp14 = tmp13;		HX_STACK_VAR(tmp14,"tmp14");
						HX_STACK_LINE(351)
						tmp9 = !(tmp14);
					}
					else{
						HX_STACK_LINE(351)
						tmp9 = true;
					}
					HX_STACK_LINE(351)
					bool tmp10 = !(tmp9);		HX_STACK_VAR(tmp10,"tmp10");
					HX_STACK_LINE(351)
					bool tmp11;		HX_STACK_VAR(tmp11,"tmp11");
					HX_STACK_LINE(351)
					if ((tmp10)){
						HX_STACK_LINE(351)
						::flixel::FlxObject tmp12 = over->object;		HX_STACK_VAR(tmp12,"tmp12");
						HX_STACK_LINE(351)
						::flixel::FlxObject tmp13 = tmp12;		HX_STACK_VAR(tmp13,"tmp13");
						HX_STACK_LINE(351)
						::flixel::plugin::_MouseEventManager::ObjectMouseData tmp14 = ::flixel::plugin::MouseEventManager_obj::getRegister(tmp13,currentOverObjects);		HX_STACK_VAR(tmp14,"tmp14");
						HX_STACK_LINE(351)
						::flixel::plugin::_MouseEventManager::ObjectMouseData tmp15 = tmp14;		HX_STACK_VAR(tmp15,"tmp15");
						HX_STACK_LINE(351)
						tmp11 = (tmp15 == null());
					}
					else{
						HX_STACK_LINE(351)
						tmp11 = true;
					}
					HX_STACK_LINE(351)
					if ((tmp11)){
						HX_STACK_LINE(353)
						::flixel::FlxObject tmp12 = over->object;		HX_STACK_VAR(tmp12,"tmp12");
						HX_STACK_LINE(353)
						over->onMouseOut(tmp12);
					}
				}
			}
		}
		HX_STACK_LINE(360)
		bool tmp;		HX_STACK_VAR(tmp,"tmp");
		HX_STACK_LINE(360)
		{
			HX_STACK_LINE(360)
			::flixel::input::mouse::FlxMouse tmp1 = ::flixel::FlxG_obj::mouse;		HX_STACK_VAR(tmp1,"tmp1");
			HX_STACK_LINE(360)
			::flixel::input::mouse::FlxMouseButton _this = tmp1->_leftButton;		HX_STACK_VAR(_this,"_this");
			HX_STACK_LINE(360)
			bool tmp2 = (_this->current == (int)2);		HX_STACK_VAR(tmp2,"tmp2");
			HX_STACK_LINE(360)
			bool tmp3 = !(tmp2);		HX_STACK_VAR(tmp3,"tmp3");
			HX_STACK_LINE(360)
			if ((tmp3)){
				HX_STACK_LINE(360)
				tmp = (_this->current == (int)-2);
			}
			else{
				HX_STACK_LINE(360)
				tmp = true;
			}
		}
		HX_STACK_LINE(360)
		if ((tmp)){
			HX_STACK_LINE(362)
			int _g = (int)0;		HX_STACK_VAR(_g,"_g");
			HX_STACK_LINE(362)
			while((true)){
				HX_STACK_LINE(362)
				bool tmp1 = (_g < currentOverObjects->length);		HX_STACK_VAR(tmp1,"tmp1");
				HX_STACK_LINE(362)
				bool tmp2 = !(tmp1);		HX_STACK_VAR(tmp2,"tmp2");
				HX_STACK_LINE(362)
				if ((tmp2)){
					HX_STACK_LINE(362)
					break;
				}
				HX_STACK_LINE(362)
				::flixel::plugin::_MouseEventManager::ObjectMouseData tmp3 = currentOverObjects->__get(_g).StaticCast< ::flixel::plugin::_MouseEventManager::ObjectMouseData >();		HX_STACK_VAR(tmp3,"tmp3");
				HX_STACK_LINE(362)
				::flixel::plugin::_MouseEventManager::ObjectMouseData current = tmp3;		HX_STACK_VAR(current,"current");
				HX_STACK_LINE(362)
				++(_g);
				HX_STACK_LINE(364)
				bool tmp4 = (current->onMouseDown != null());		HX_STACK_VAR(tmp4,"tmp4");
				HX_STACK_LINE(364)
				bool tmp5 = tmp4;		HX_STACK_VAR(tmp5,"tmp5");
				HX_STACK_LINE(364)
				bool tmp6;		HX_STACK_VAR(tmp6,"tmp6");
				HX_STACK_LINE(364)
				if ((tmp5)){
					HX_STACK_LINE(364)
					tmp6 = current->object->exists;
				}
				else{
					HX_STACK_LINE(364)
					tmp6 = false;
				}
				HX_STACK_LINE(364)
				bool tmp7;		HX_STACK_VAR(tmp7,"tmp7");
				HX_STACK_LINE(364)
				if ((tmp6)){
					HX_STACK_LINE(364)
					tmp7 = current->object->visible;
				}
				else{
					HX_STACK_LINE(364)
					tmp7 = false;
				}
				HX_STACK_LINE(364)
				if ((tmp7)){
					HX_STACK_LINE(366)
					::flixel::FlxObject tmp8 = current->object;		HX_STACK_VAR(tmp8,"tmp8");
					HX_STACK_LINE(366)
					current->onMouseDown(tmp8);
				}
			}
		}
		HX_STACK_LINE(372)
		bool tmp1;		HX_STACK_VAR(tmp1,"tmp1");
		HX_STACK_LINE(372)
		{
			HX_STACK_LINE(372)
			::flixel::input::mouse::FlxMouse tmp2 = ::flixel::FlxG_obj::mouse;		HX_STACK_VAR(tmp2,"tmp2");
			HX_STACK_LINE(372)
			::flixel::input::mouse::FlxMouseButton _this = tmp2->_leftButton;		HX_STACK_VAR(_this,"_this");
			HX_STACK_LINE(372)
			bool tmp3 = (_this->current == (int)-1);		HX_STACK_VAR(tmp3,"tmp3");
			HX_STACK_LINE(372)
			bool tmp4 = !(tmp3);		HX_STACK_VAR(tmp4,"tmp4");
			HX_STACK_LINE(372)
			if ((tmp4)){
				HX_STACK_LINE(372)
				tmp1 = (_this->current == (int)-2);
			}
			else{
				HX_STACK_LINE(372)
				tmp1 = true;
			}
		}
		HX_STACK_LINE(372)
		if ((tmp1)){
			HX_STACK_LINE(374)
			int _g = (int)0;		HX_STACK_VAR(_g,"_g");
			HX_STACK_LINE(374)
			while((true)){
				HX_STACK_LINE(374)
				bool tmp2 = (_g < currentOverObjects->length);		HX_STACK_VAR(tmp2,"tmp2");
				HX_STACK_LINE(374)
				bool tmp3 = !(tmp2);		HX_STACK_VAR(tmp3,"tmp3");
				HX_STACK_LINE(374)
				if ((tmp3)){
					HX_STACK_LINE(374)
					break;
				}
				HX_STACK_LINE(374)
				::flixel::plugin::_MouseEventManager::ObjectMouseData tmp4 = currentOverObjects->__get(_g).StaticCast< ::flixel::plugin::_MouseEventManager::ObjectMouseData >();		HX_STACK_VAR(tmp4,"tmp4");
				HX_STACK_LINE(374)
				::flixel::plugin::_MouseEventManager::ObjectMouseData current = tmp4;		HX_STACK_VAR(current,"current");
				HX_STACK_LINE(374)
				++(_g);
				HX_STACK_LINE(376)
				bool tmp5 = (current->onMouseUp != null());		HX_STACK_VAR(tmp5,"tmp5");
				HX_STACK_LINE(376)
				bool tmp6 = tmp5;		HX_STACK_VAR(tmp6,"tmp6");
				HX_STACK_LINE(376)
				bool tmp7;		HX_STACK_VAR(tmp7,"tmp7");
				HX_STACK_LINE(376)
				if ((tmp6)){
					HX_STACK_LINE(376)
					tmp7 = current->object->exists;
				}
				else{
					HX_STACK_LINE(376)
					tmp7 = false;
				}
				HX_STACK_LINE(376)
				bool tmp8;		HX_STACK_VAR(tmp8,"tmp8");
				HX_STACK_LINE(376)
				if ((tmp7)){
					HX_STACK_LINE(376)
					tmp8 = current->object->visible;
				}
				else{
					HX_STACK_LINE(376)
					tmp8 = false;
				}
				HX_STACK_LINE(376)
				if ((tmp8)){
					HX_STACK_LINE(378)
					::flixel::FlxObject tmp9 = current->object;		HX_STACK_VAR(tmp9,"tmp9");
					HX_STACK_LINE(378)
					current->onMouseUp(tmp9);
				}
			}
		}
		HX_STACK_LINE(384)
		::flixel::plugin::MouseEventManager_obj::_mouseOverObjects = currentOverObjects;
	}
return null();
}


Void MouseEventManager_obj::clearRegistry( ){
{
		HX_STACK_FRAME("flixel.plugin.MouseEventManager","clearRegistry",0x3dcef6ab,"flixel.plugin.MouseEventManager.clearRegistry","flixel/plugin/MouseEventManager.hx",388,0x4767214f)
		HX_STACK_THIS(this)
		HX_STACK_LINE(389)
		::flixel::plugin::MouseEventManager_obj::_mouseOverObjects = null();
		HX_STACK_LINE(391)
		{
			HX_STACK_LINE(391)
			int _g = (int)0;		HX_STACK_VAR(_g,"_g");
			HX_STACK_LINE(391)
			Array< ::Dynamic > _g1 = ::flixel::plugin::MouseEventManager_obj::_registeredObjects;		HX_STACK_VAR(_g1,"_g1");
			HX_STACK_LINE(391)
			while((true)){
				HX_STACK_LINE(391)
				bool tmp = (_g < _g1->length);		HX_STACK_VAR(tmp,"tmp");
				HX_STACK_LINE(391)
				bool tmp1 = !(tmp);		HX_STACK_VAR(tmp1,"tmp1");
				HX_STACK_LINE(391)
				if ((tmp1)){
					HX_STACK_LINE(391)
					break;
				}
				HX_STACK_LINE(391)
				::flixel::plugin::_MouseEventManager::ObjectMouseData tmp2 = _g1->__get(_g).StaticCast< ::flixel::plugin::_MouseEventManager::ObjectMouseData >();		HX_STACK_VAR(tmp2,"tmp2");
				HX_STACK_LINE(391)
				::flixel::plugin::_MouseEventManager::ObjectMouseData reg = tmp2;		HX_STACK_VAR(reg,"reg");
				HX_STACK_LINE(391)
				++(_g);
				HX_STACK_LINE(393)
				::flixel::FlxObject tmp3 = reg->object;		HX_STACK_VAR(tmp3,"tmp3");
				HX_STACK_LINE(393)
				::flixel::plugin::MouseEventManager_obj::remove(tmp3);
			}
		}
		HX_STACK_LINE(396)
		::flixel::plugin::MouseEventManager_obj::_registeredObjects = null();
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC0(MouseEventManager_obj,clearRegistry,(void))

bool MouseEventManager_obj::checkOverlap( ::flixel::plugin::_MouseEventManager::ObjectMouseData Register){
	HX_STACK_FRAME("flixel.plugin.MouseEventManager","checkOverlap",0x1f757c7e,"flixel.plugin.MouseEventManager.checkOverlap","flixel/plugin/MouseEventManager.hx",400,0x4767214f)
	HX_STACK_THIS(this)
	HX_STACK_ARG(Register,"Register")
	HX_STACK_LINE(401)
	{
		HX_STACK_LINE(401)
		int _g = (int)0;		HX_STACK_VAR(_g,"_g");
		HX_STACK_LINE(401)
		Array< ::Dynamic > _g1 = Register->object->get_cameras();		HX_STACK_VAR(_g1,"_g1");
		HX_STACK_LINE(401)
		while((true)){
			HX_STACK_LINE(401)
			bool tmp = (_g < _g1->length);		HX_STACK_VAR(tmp,"tmp");
			HX_STACK_LINE(401)
			bool tmp1 = !(tmp);		HX_STACK_VAR(tmp1,"tmp1");
			HX_STACK_LINE(401)
			if ((tmp1)){
				HX_STACK_LINE(401)
				break;
			}
			HX_STACK_LINE(401)
			::flixel::FlxCamera tmp2 = _g1->__get(_g).StaticCast< ::flixel::FlxCamera >();		HX_STACK_VAR(tmp2,"tmp2");
			HX_STACK_LINE(401)
			::flixel::FlxCamera camera = tmp2;		HX_STACK_VAR(camera,"camera");
			HX_STACK_LINE(401)
			++(_g);
			HX_STACK_LINE(404)
			::flixel::input::mouse::FlxMouse tmp3 = ::flixel::FlxG_obj::mouse;		HX_STACK_VAR(tmp3,"tmp3");
			HX_STACK_LINE(404)
			::flixel::FlxCamera tmp4 = camera;		HX_STACK_VAR(tmp4,"tmp4");
			HX_STACK_LINE(404)
			::flixel::util::FlxPoint tmp5 = ::flixel::plugin::MouseEventManager_obj::_point;		HX_STACK_VAR(tmp5,"tmp5");
			HX_STACK_LINE(404)
			::flixel::util::FlxPoint tmp6 = tmp3->getWorldPosition(tmp4,tmp5);		HX_STACK_VAR(tmp6,"tmp6");
			HX_STACK_LINE(404)
			::flixel::plugin::MouseEventManager_obj::_point = tmp6;
			HX_STACK_LINE(406)
			bool tmp7;		HX_STACK_VAR(tmp7,"tmp7");
			HX_STACK_LINE(406)
			{
				HX_STACK_LINE(406)
				::flixel::util::FlxPoint tmp8 = ::flixel::plugin::MouseEventManager_obj::_point;		HX_STACK_VAR(tmp8,"tmp8");
				HX_STACK_LINE(406)
				::flixel::util::FlxPoint Point = tmp8;		HX_STACK_VAR(Point,"Point");
				HX_STACK_LINE(406)
				bool tmp9 = Register->pixelPerfect;		HX_STACK_VAR(tmp9,"tmp9");
				HX_STACK_LINE(406)
				bool tmp10;		HX_STACK_VAR(tmp10,"tmp10");
				HX_STACK_LINE(406)
				if ((tmp9)){
					HX_STACK_LINE(406)
					tmp10 = (Register->sprite != null());
				}
				else{
					HX_STACK_LINE(406)
					tmp10 = false;
				}
				HX_STACK_LINE(406)
				if ((tmp10)){
					HX_STACK_LINE(406)
					::flixel::FlxSprite Sprite = Register->sprite;		HX_STACK_VAR(Sprite,"Sprite");
					HX_STACK_LINE(406)
					bool tmp11 = (Sprite->angle != (int)0);		HX_STACK_VAR(tmp11,"tmp11");
					HX_STACK_LINE(406)
					if ((tmp11)){
						HX_STACK_LINE(406)
						Float tmp12 = Sprite->x;		HX_STACK_VAR(tmp12,"tmp12");
						HX_STACK_LINE(406)
						Float tmp13 = Sprite->origin->x;		HX_STACK_VAR(tmp13,"tmp13");
						HX_STACK_LINE(406)
						Float tmp14 = (tmp12 + tmp13);		HX_STACK_VAR(tmp14,"tmp14");
						HX_STACK_LINE(406)
						Float PivotX = tmp14;		HX_STACK_VAR(PivotX,"PivotX");
						HX_STACK_LINE(406)
						Float tmp15 = Sprite->y;		HX_STACK_VAR(tmp15,"tmp15");
						HX_STACK_LINE(406)
						Float tmp16 = Sprite->origin->y;		HX_STACK_VAR(tmp16,"tmp16");
						HX_STACK_LINE(406)
						Float tmp17 = (tmp15 + tmp16);		HX_STACK_VAR(tmp17,"tmp17");
						HX_STACK_LINE(406)
						Float PivotY = tmp17;		HX_STACK_VAR(PivotY,"PivotY");
						HX_STACK_LINE(406)
						::flixel::util::FlxPoint point = Point;		HX_STACK_VAR(point,"point");
						HX_STACK_LINE(406)
						Float sin = (int)0;		HX_STACK_VAR(sin,"sin");
						HX_STACK_LINE(406)
						Float cos = (int)0;		HX_STACK_VAR(cos,"cos");
						HX_STACK_LINE(406)
						Float tmp18 = (Sprite->angle - (int)180);		HX_STACK_VAR(tmp18,"tmp18");
						HX_STACK_LINE(406)
						Float tmp19 = ::Math_obj::PI;		HX_STACK_VAR(tmp19,"tmp19");
						HX_STACK_LINE(406)
						Float tmp20 = (Float(tmp19) / Float((int)180));		HX_STACK_VAR(tmp20,"tmp20");
						HX_STACK_LINE(406)
						Float tmp21 = -(tmp20);		HX_STACK_VAR(tmp21,"tmp21");
						HX_STACK_LINE(406)
						Float tmp22 = (tmp18 * tmp21);		HX_STACK_VAR(tmp22,"tmp22");
						HX_STACK_LINE(406)
						Float radians = tmp22;		HX_STACK_VAR(radians,"radians");
						HX_STACK_LINE(406)
						while((true)){
							HX_STACK_LINE(406)
							Float tmp23 = radians;		HX_STACK_VAR(tmp23,"tmp23");
							HX_STACK_LINE(406)
							Float tmp24 = ::Math_obj::PI;		HX_STACK_VAR(tmp24,"tmp24");
							HX_STACK_LINE(406)
							Float tmp25 = -(tmp24);		HX_STACK_VAR(tmp25,"tmp25");
							HX_STACK_LINE(406)
							bool tmp26 = (tmp23 < tmp25);		HX_STACK_VAR(tmp26,"tmp26");
							HX_STACK_LINE(406)
							bool tmp27 = !(tmp26);		HX_STACK_VAR(tmp27,"tmp27");
							HX_STACK_LINE(406)
							if ((tmp27)){
								HX_STACK_LINE(406)
								break;
							}
							HX_STACK_LINE(406)
							Float tmp28 = ::Math_obj::PI;		HX_STACK_VAR(tmp28,"tmp28");
							HX_STACK_LINE(406)
							Float tmp29 = (tmp28 * (int)2);		HX_STACK_VAR(tmp29,"tmp29");
							HX_STACK_LINE(406)
							hx::AddEq(radians,tmp29);
						}
						HX_STACK_LINE(406)
						while((true)){
							HX_STACK_LINE(406)
							Float tmp23 = radians;		HX_STACK_VAR(tmp23,"tmp23");
							HX_STACK_LINE(406)
							Float tmp24 = ::Math_obj::PI;		HX_STACK_VAR(tmp24,"tmp24");
							HX_STACK_LINE(406)
							bool tmp25 = (tmp23 > tmp24);		HX_STACK_VAR(tmp25,"tmp25");
							HX_STACK_LINE(406)
							bool tmp26 = !(tmp25);		HX_STACK_VAR(tmp26,"tmp26");
							HX_STACK_LINE(406)
							if ((tmp26)){
								HX_STACK_LINE(406)
								break;
							}
							HX_STACK_LINE(406)
							Float tmp27 = radians;		HX_STACK_VAR(tmp27,"tmp27");
							HX_STACK_LINE(406)
							Float tmp28 = ::Math_obj::PI;		HX_STACK_VAR(tmp28,"tmp28");
							HX_STACK_LINE(406)
							Float tmp29 = (tmp28 * (int)2);		HX_STACK_VAR(tmp29,"tmp29");
							HX_STACK_LINE(406)
							Float tmp30 = (tmp27 - tmp29);		HX_STACK_VAR(tmp30,"tmp30");
							HX_STACK_LINE(406)
							radians = tmp30;
						}
						HX_STACK_LINE(406)
						bool tmp23 = (radians < (int)0);		HX_STACK_VAR(tmp23,"tmp23");
						HX_STACK_LINE(406)
						if ((tmp23)){
							HX_STACK_LINE(406)
							Float tmp24 = (((Float)1.27323954) * radians);		HX_STACK_VAR(tmp24,"tmp24");
							HX_STACK_LINE(406)
							Float tmp25 = (((Float).405284735) * radians);		HX_STACK_VAR(tmp25,"tmp25");
							HX_STACK_LINE(406)
							Float tmp26 = radians;		HX_STACK_VAR(tmp26,"tmp26");
							HX_STACK_LINE(406)
							Float tmp27 = (tmp25 * tmp26);		HX_STACK_VAR(tmp27,"tmp27");
							HX_STACK_LINE(406)
							Float tmp28 = (tmp24 + tmp27);		HX_STACK_VAR(tmp28,"tmp28");
							HX_STACK_LINE(406)
							sin = tmp28;
							HX_STACK_LINE(406)
							bool tmp29 = (sin < (int)0);		HX_STACK_VAR(tmp29,"tmp29");
							HX_STACK_LINE(406)
							if ((tmp29)){
								HX_STACK_LINE(406)
								Float tmp30 = sin;		HX_STACK_VAR(tmp30,"tmp30");
								HX_STACK_LINE(406)
								Float tmp31 = sin;		HX_STACK_VAR(tmp31,"tmp31");
								HX_STACK_LINE(406)
								Float tmp32 = -(tmp31);		HX_STACK_VAR(tmp32,"tmp32");
								HX_STACK_LINE(406)
								Float tmp33 = (tmp30 * tmp32);		HX_STACK_VAR(tmp33,"tmp33");
								HX_STACK_LINE(406)
								Float tmp34 = sin;		HX_STACK_VAR(tmp34,"tmp34");
								HX_STACK_LINE(406)
								Float tmp35 = (tmp33 - tmp34);		HX_STACK_VAR(tmp35,"tmp35");
								HX_STACK_LINE(406)
								Float tmp36 = (((Float).225) * tmp35);		HX_STACK_VAR(tmp36,"tmp36");
								HX_STACK_LINE(406)
								Float tmp37 = sin;		HX_STACK_VAR(tmp37,"tmp37");
								HX_STACK_LINE(406)
								Float tmp38 = (tmp36 + tmp37);		HX_STACK_VAR(tmp38,"tmp38");
								HX_STACK_LINE(406)
								sin = tmp38;
							}
							else{
								HX_STACK_LINE(406)
								Float tmp30 = (sin * sin);		HX_STACK_VAR(tmp30,"tmp30");
								HX_STACK_LINE(406)
								Float tmp31 = sin;		HX_STACK_VAR(tmp31,"tmp31");
								HX_STACK_LINE(406)
								Float tmp32 = (tmp30 - tmp31);		HX_STACK_VAR(tmp32,"tmp32");
								HX_STACK_LINE(406)
								Float tmp33 = (((Float).225) * tmp32);		HX_STACK_VAR(tmp33,"tmp33");
								HX_STACK_LINE(406)
								Float tmp34 = sin;		HX_STACK_VAR(tmp34,"tmp34");
								HX_STACK_LINE(406)
								Float tmp35 = (tmp33 + tmp34);		HX_STACK_VAR(tmp35,"tmp35");
								HX_STACK_LINE(406)
								sin = tmp35;
							}
						}
						else{
							HX_STACK_LINE(406)
							Float tmp24 = (((Float)1.27323954) * radians);		HX_STACK_VAR(tmp24,"tmp24");
							HX_STACK_LINE(406)
							Float tmp25 = (((Float)0.405284735) * radians);		HX_STACK_VAR(tmp25,"tmp25");
							HX_STACK_LINE(406)
							Float tmp26 = radians;		HX_STACK_VAR(tmp26,"tmp26");
							HX_STACK_LINE(406)
							Float tmp27 = (tmp25 * tmp26);		HX_STACK_VAR(tmp27,"tmp27");
							HX_STACK_LINE(406)
							Float tmp28 = (tmp24 - tmp27);		HX_STACK_VAR(tmp28,"tmp28");
							HX_STACK_LINE(406)
							sin = tmp28;
							HX_STACK_LINE(406)
							bool tmp29 = (sin < (int)0);		HX_STACK_VAR(tmp29,"tmp29");
							HX_STACK_LINE(406)
							if ((tmp29)){
								HX_STACK_LINE(406)
								Float tmp30 = sin;		HX_STACK_VAR(tmp30,"tmp30");
								HX_STACK_LINE(406)
								Float tmp31 = sin;		HX_STACK_VAR(tmp31,"tmp31");
								HX_STACK_LINE(406)
								Float tmp32 = -(tmp31);		HX_STACK_VAR(tmp32,"tmp32");
								HX_STACK_LINE(406)
								Float tmp33 = (tmp30 * tmp32);		HX_STACK_VAR(tmp33,"tmp33");
								HX_STACK_LINE(406)
								Float tmp34 = sin;		HX_STACK_VAR(tmp34,"tmp34");
								HX_STACK_LINE(406)
								Float tmp35 = (tmp33 - tmp34);		HX_STACK_VAR(tmp35,"tmp35");
								HX_STACK_LINE(406)
								Float tmp36 = (((Float).225) * tmp35);		HX_STACK_VAR(tmp36,"tmp36");
								HX_STACK_LINE(406)
								Float tmp37 = sin;		HX_STACK_VAR(tmp37,"tmp37");
								HX_STACK_LINE(406)
								Float tmp38 = (tmp36 + tmp37);		HX_STACK_VAR(tmp38,"tmp38");
								HX_STACK_LINE(406)
								sin = tmp38;
							}
							else{
								HX_STACK_LINE(406)
								Float tmp30 = (sin * sin);		HX_STACK_VAR(tmp30,"tmp30");
								HX_STACK_LINE(406)
								Float tmp31 = sin;		HX_STACK_VAR(tmp31,"tmp31");
								HX_STACK_LINE(406)
								Float tmp32 = (tmp30 - tmp31);		HX_STACK_VAR(tmp32,"tmp32");
								HX_STACK_LINE(406)
								Float tmp33 = (((Float).225) * tmp32);		HX_STACK_VAR(tmp33,"tmp33");
								HX_STACK_LINE(406)
								Float tmp34 = sin;		HX_STACK_VAR(tmp34,"tmp34");
								HX_STACK_LINE(406)
								Float tmp35 = (tmp33 + tmp34);		HX_STACK_VAR(tmp35,"tmp35");
								HX_STACK_LINE(406)
								sin = tmp35;
							}
						}
						HX_STACK_LINE(406)
						Float tmp24 = ::Math_obj::PI;		HX_STACK_VAR(tmp24,"tmp24");
						HX_STACK_LINE(406)
						Float tmp25 = (Float(tmp24) / Float((int)2));		HX_STACK_VAR(tmp25,"tmp25");
						HX_STACK_LINE(406)
						hx::AddEq(radians,tmp25);
						HX_STACK_LINE(406)
						Float tmp26 = radians;		HX_STACK_VAR(tmp26,"tmp26");
						HX_STACK_LINE(406)
						Float tmp27 = ::Math_obj::PI;		HX_STACK_VAR(tmp27,"tmp27");
						HX_STACK_LINE(406)
						bool tmp28 = (tmp26 > tmp27);		HX_STACK_VAR(tmp28,"tmp28");
						HX_STACK_LINE(406)
						if ((tmp28)){
							HX_STACK_LINE(406)
							Float tmp29 = radians;		HX_STACK_VAR(tmp29,"tmp29");
							HX_STACK_LINE(406)
							Float tmp30 = ::Math_obj::PI;		HX_STACK_VAR(tmp30,"tmp30");
							HX_STACK_LINE(406)
							Float tmp31 = (tmp30 * (int)2);		HX_STACK_VAR(tmp31,"tmp31");
							HX_STACK_LINE(406)
							Float tmp32 = (tmp29 - tmp31);		HX_STACK_VAR(tmp32,"tmp32");
							HX_STACK_LINE(406)
							radians = tmp32;
						}
						HX_STACK_LINE(406)
						bool tmp29 = (radians < (int)0);		HX_STACK_VAR(tmp29,"tmp29");
						HX_STACK_LINE(406)
						if ((tmp29)){
							HX_STACK_LINE(406)
							Float tmp30 = (((Float)1.27323954) * radians);		HX_STACK_VAR(tmp30,"tmp30");
							HX_STACK_LINE(406)
							Float tmp31 = (((Float)0.405284735) * radians);		HX_STACK_VAR(tmp31,"tmp31");
							HX_STACK_LINE(406)
							Float tmp32 = radians;		HX_STACK_VAR(tmp32,"tmp32");
							HX_STACK_LINE(406)
							Float tmp33 = (tmp31 * tmp32);		HX_STACK_VAR(tmp33,"tmp33");
							HX_STACK_LINE(406)
							Float tmp34 = (tmp30 + tmp33);		HX_STACK_VAR(tmp34,"tmp34");
							HX_STACK_LINE(406)
							cos = tmp34;
							HX_STACK_LINE(406)
							bool tmp35 = (cos < (int)0);		HX_STACK_VAR(tmp35,"tmp35");
							HX_STACK_LINE(406)
							if ((tmp35)){
								HX_STACK_LINE(406)
								Float tmp36 = cos;		HX_STACK_VAR(tmp36,"tmp36");
								HX_STACK_LINE(406)
								Float tmp37 = cos;		HX_STACK_VAR(tmp37,"tmp37");
								HX_STACK_LINE(406)
								Float tmp38 = -(tmp37);		HX_STACK_VAR(tmp38,"tmp38");
								HX_STACK_LINE(406)
								Float tmp39 = (tmp36 * tmp38);		HX_STACK_VAR(tmp39,"tmp39");
								HX_STACK_LINE(406)
								Float tmp40 = cos;		HX_STACK_VAR(tmp40,"tmp40");
								HX_STACK_LINE(406)
								Float tmp41 = (tmp39 - tmp40);		HX_STACK_VAR(tmp41,"tmp41");
								HX_STACK_LINE(406)
								Float tmp42 = (((Float).225) * tmp41);		HX_STACK_VAR(tmp42,"tmp42");
								HX_STACK_LINE(406)
								Float tmp43 = cos;		HX_STACK_VAR(tmp43,"tmp43");
								HX_STACK_LINE(406)
								Float tmp44 = (tmp42 + tmp43);		HX_STACK_VAR(tmp44,"tmp44");
								HX_STACK_LINE(406)
								cos = tmp44;
							}
							else{
								HX_STACK_LINE(406)
								Float tmp36 = (cos * cos);		HX_STACK_VAR(tmp36,"tmp36");
								HX_STACK_LINE(406)
								Float tmp37 = cos;		HX_STACK_VAR(tmp37,"tmp37");
								HX_STACK_LINE(406)
								Float tmp38 = (tmp36 - tmp37);		HX_STACK_VAR(tmp38,"tmp38");
								HX_STACK_LINE(406)
								Float tmp39 = (((Float).225) * tmp38);		HX_STACK_VAR(tmp39,"tmp39");
								HX_STACK_LINE(406)
								Float tmp40 = cos;		HX_STACK_VAR(tmp40,"tmp40");
								HX_STACK_LINE(406)
								Float tmp41 = (tmp39 + tmp40);		HX_STACK_VAR(tmp41,"tmp41");
								HX_STACK_LINE(406)
								cos = tmp41;
							}
						}
						else{
							HX_STACK_LINE(406)
							Float tmp30 = (((Float)1.27323954) * radians);		HX_STACK_VAR(tmp30,"tmp30");
							HX_STACK_LINE(406)
							Float tmp31 = (((Float)0.405284735) * radians);		HX_STACK_VAR(tmp31,"tmp31");
							HX_STACK_LINE(406)
							Float tmp32 = radians;		HX_STACK_VAR(tmp32,"tmp32");
							HX_STACK_LINE(406)
							Float tmp33 = (tmp31 * tmp32);		HX_STACK_VAR(tmp33,"tmp33");
							HX_STACK_LINE(406)
							Float tmp34 = (tmp30 - tmp33);		HX_STACK_VAR(tmp34,"tmp34");
							HX_STACK_LINE(406)
							cos = tmp34;
							HX_STACK_LINE(406)
							bool tmp35 = (cos < (int)0);		HX_STACK_VAR(tmp35,"tmp35");
							HX_STACK_LINE(406)
							if ((tmp35)){
								HX_STACK_LINE(406)
								Float tmp36 = cos;		HX_STACK_VAR(tmp36,"tmp36");
								HX_STACK_LINE(406)
								Float tmp37 = cos;		HX_STACK_VAR(tmp37,"tmp37");
								HX_STACK_LINE(406)
								Float tmp38 = -(tmp37);		HX_STACK_VAR(tmp38,"tmp38");
								HX_STACK_LINE(406)
								Float tmp39 = (tmp36 * tmp38);		HX_STACK_VAR(tmp39,"tmp39");
								HX_STACK_LINE(406)
								Float tmp40 = cos;		HX_STACK_VAR(tmp40,"tmp40");
								HX_STACK_LINE(406)
								Float tmp41 = (tmp39 - tmp40);		HX_STACK_VAR(tmp41,"tmp41");
								HX_STACK_LINE(406)
								Float tmp42 = (((Float).225) * tmp41);		HX_STACK_VAR(tmp42,"tmp42");
								HX_STACK_LINE(406)
								Float tmp43 = cos;		HX_STACK_VAR(tmp43,"tmp43");
								HX_STACK_LINE(406)
								Float tmp44 = (tmp42 + tmp43);		HX_STACK_VAR(tmp44,"tmp44");
								HX_STACK_LINE(406)
								cos = tmp44;
							}
							else{
								HX_STACK_LINE(406)
								Float tmp36 = (cos * cos);		HX_STACK_VAR(tmp36,"tmp36");
								HX_STACK_LINE(406)
								Float tmp37 = cos;		HX_STACK_VAR(tmp37,"tmp37");
								HX_STACK_LINE(406)
								Float tmp38 = (tmp36 - tmp37);		HX_STACK_VAR(tmp38,"tmp38");
								HX_STACK_LINE(406)
								Float tmp39 = (((Float).225) * tmp38);		HX_STACK_VAR(tmp39,"tmp39");
								HX_STACK_LINE(406)
								Float tmp40 = cos;		HX_STACK_VAR(tmp40,"tmp40");
								HX_STACK_LINE(406)
								Float tmp41 = (tmp39 + tmp40);		HX_STACK_VAR(tmp41,"tmp41");
								HX_STACK_LINE(406)
								cos = tmp41;
							}
						}
						HX_STACK_LINE(406)
						Float tmp30 = (Point->x - PivotX);		HX_STACK_VAR(tmp30,"tmp30");
						HX_STACK_LINE(406)
						Float dx = tmp30;		HX_STACK_VAR(dx,"dx");
						HX_STACK_LINE(406)
						Float tmp31 = (Point->y - PivotY);		HX_STACK_VAR(tmp31,"tmp31");
						HX_STACK_LINE(406)
						Float dy = tmp31;		HX_STACK_VAR(dy,"dy");
						HX_STACK_LINE(406)
						bool tmp32 = (point == null());		HX_STACK_VAR(tmp32,"tmp32");
						HX_STACK_LINE(406)
						if ((tmp32)){
							HX_STACK_LINE(406)
							::flixel::util::FlxPoint tmp33;		HX_STACK_VAR(tmp33,"tmp33");
							HX_STACK_LINE(406)
							{
								HX_STACK_LINE(406)
								Float X = (int)0;		HX_STACK_VAR(X,"X");
								HX_STACK_LINE(406)
								Float Y = (int)0;		HX_STACK_VAR(Y,"Y");
								HX_STACK_LINE(406)
								::flixel::util::FlxPool tmp34 = ::flixel::util::FlxPoint_obj::_pool;		HX_STACK_VAR(tmp34,"tmp34");
								HX_STACK_LINE(406)
								::flixel::util::FlxPoint tmp35 = tmp34->get();		HX_STACK_VAR(tmp35,"tmp35");
								HX_STACK_LINE(406)
								Float tmp36 = X;		HX_STACK_VAR(tmp36,"tmp36");
								HX_STACK_LINE(406)
								Float tmp37 = Y;		HX_STACK_VAR(tmp37,"tmp37");
								HX_STACK_LINE(406)
								::flixel::util::FlxPoint tmp38 = tmp35->set(tmp36,tmp37);		HX_STACK_VAR(tmp38,"tmp38");
								HX_STACK_LINE(406)
								::flixel::util::FlxPoint point1 = tmp38;		HX_STACK_VAR(point1,"point1");
								HX_STACK_LINE(406)
								point1->_inPool = false;
								HX_STACK_LINE(406)
								tmp33 = point1;
							}
							HX_STACK_LINE(406)
							point = tmp33;
						}
						HX_STACK_LINE(406)
						Float tmp33 = PivotX;		HX_STACK_VAR(tmp33,"tmp33");
						HX_STACK_LINE(406)
						Float tmp34 = (cos * dx);		HX_STACK_VAR(tmp34,"tmp34");
						HX_STACK_LINE(406)
						Float tmp35 = (tmp33 + tmp34);		HX_STACK_VAR(tmp35,"tmp35");
						HX_STACK_LINE(406)
						Float tmp36 = (sin * dy);		HX_STACK_VAR(tmp36,"tmp36");
						HX_STACK_LINE(406)
						Float tmp37 = (tmp35 - tmp36);		HX_STACK_VAR(tmp37,"tmp37");
						HX_STACK_LINE(406)
						point->set_x(tmp37);
						HX_STACK_LINE(406)
						Float tmp38 = PivotY;		HX_STACK_VAR(tmp38,"tmp38");
						HX_STACK_LINE(406)
						Float tmp39 = (sin * dx);		HX_STACK_VAR(tmp39,"tmp39");
						HX_STACK_LINE(406)
						Float tmp40 = (tmp38 - tmp39);		HX_STACK_VAR(tmp40,"tmp40");
						HX_STACK_LINE(406)
						Float tmp41 = (cos * dy);		HX_STACK_VAR(tmp41,"tmp41");
						HX_STACK_LINE(406)
						Float tmp42 = (tmp40 - tmp41);		HX_STACK_VAR(tmp42,"tmp42");
						HX_STACK_LINE(406)
						point->set_y(tmp42);
						HX_STACK_LINE(406)
						point;
					}
					HX_STACK_LINE(406)
					::flixel::util::FlxPoint tmp12 = Point;		HX_STACK_VAR(tmp12,"tmp12");
					HX_STACK_LINE(406)
					::flixel::FlxCamera tmp13 = camera;		HX_STACK_VAR(tmp13,"tmp13");
					HX_STACK_LINE(406)
					tmp7 = Sprite->pixelsOverlapPoint(tmp12,(int)1,tmp13);
				}
				else{
					HX_STACK_LINE(406)
					::flixel::util::FlxPoint tmp11 = Point;		HX_STACK_VAR(tmp11,"tmp11");
					HX_STACK_LINE(406)
					::flixel::FlxCamera tmp12 = camera;		HX_STACK_VAR(tmp12,"tmp12");
					HX_STACK_LINE(406)
					tmp7 = Register->object->overlapsPoint(tmp11,true,tmp12);
				}
			}
			HX_STACK_LINE(406)
			if ((tmp7)){
				HX_STACK_LINE(408)
				return true;
			}
			HX_STACK_LINE(413)
			{
				HX_STACK_LINE(413)
				int _g2 = (int)0;		HX_STACK_VAR(_g2,"_g2");
				HX_STACK_LINE(413)
				::flixel::input::touch::FlxTouchManager tmp8 = ::flixel::FlxG_obj::touches;		HX_STACK_VAR(tmp8,"tmp8");
				HX_STACK_LINE(413)
				Array< ::Dynamic > _g3 = tmp8->list;		HX_STACK_VAR(_g3,"_g3");
				HX_STACK_LINE(413)
				while((true)){
					HX_STACK_LINE(413)
					bool tmp9 = (_g2 < _g3->length);		HX_STACK_VAR(tmp9,"tmp9");
					HX_STACK_LINE(413)
					bool tmp10 = !(tmp9);		HX_STACK_VAR(tmp10,"tmp10");
					HX_STACK_LINE(413)
					if ((tmp10)){
						HX_STACK_LINE(413)
						break;
					}
					HX_STACK_LINE(413)
					::flixel::input::touch::FlxTouch tmp11 = _g3->__get(_g2).StaticCast< ::flixel::input::touch::FlxTouch >();		HX_STACK_VAR(tmp11,"tmp11");
					HX_STACK_LINE(413)
					::flixel::input::touch::FlxTouch touch = tmp11;		HX_STACK_VAR(touch,"touch");
					HX_STACK_LINE(413)
					++(_g2);
					HX_STACK_LINE(415)
					::flixel::FlxCamera tmp12 = camera;		HX_STACK_VAR(tmp12,"tmp12");
					HX_STACK_LINE(415)
					::flixel::util::FlxPoint tmp13 = ::flixel::plugin::MouseEventManager_obj::_point;		HX_STACK_VAR(tmp13,"tmp13");
					HX_STACK_LINE(415)
					::flixel::util::FlxPoint tmp14 = touch->getWorldPosition(tmp12,tmp13);		HX_STACK_VAR(tmp14,"tmp14");
					HX_STACK_LINE(415)
					::flixel::plugin::MouseEventManager_obj::_point = tmp14;
					HX_STACK_LINE(417)
					bool tmp15;		HX_STACK_VAR(tmp15,"tmp15");
					HX_STACK_LINE(417)
					{
						HX_STACK_LINE(417)
						::flixel::util::FlxPoint tmp16 = ::flixel::plugin::MouseEventManager_obj::_point;		HX_STACK_VAR(tmp16,"tmp16");
						HX_STACK_LINE(417)
						::flixel::util::FlxPoint Point = tmp16;		HX_STACK_VAR(Point,"Point");
						HX_STACK_LINE(417)
						bool tmp17 = Register->pixelPerfect;		HX_STACK_VAR(tmp17,"tmp17");
						HX_STACK_LINE(417)
						bool tmp18;		HX_STACK_VAR(tmp18,"tmp18");
						HX_STACK_LINE(417)
						if ((tmp17)){
							HX_STACK_LINE(417)
							tmp18 = (Register->sprite != null());
						}
						else{
							HX_STACK_LINE(417)
							tmp18 = false;
						}
						HX_STACK_LINE(417)
						if ((tmp18)){
							HX_STACK_LINE(417)
							::flixel::FlxSprite Sprite = Register->sprite;		HX_STACK_VAR(Sprite,"Sprite");
							HX_STACK_LINE(417)
							bool tmp19 = (Sprite->angle != (int)0);		HX_STACK_VAR(tmp19,"tmp19");
							HX_STACK_LINE(417)
							if ((tmp19)){
								HX_STACK_LINE(417)
								Float tmp20 = Sprite->x;		HX_STACK_VAR(tmp20,"tmp20");
								HX_STACK_LINE(417)
								Float tmp21 = Sprite->origin->x;		HX_STACK_VAR(tmp21,"tmp21");
								HX_STACK_LINE(417)
								Float tmp22 = (tmp20 + tmp21);		HX_STACK_VAR(tmp22,"tmp22");
								HX_STACK_LINE(417)
								Float PivotX = tmp22;		HX_STACK_VAR(PivotX,"PivotX");
								HX_STACK_LINE(417)
								Float tmp23 = Sprite->y;		HX_STACK_VAR(tmp23,"tmp23");
								HX_STACK_LINE(417)
								Float tmp24 = Sprite->origin->y;		HX_STACK_VAR(tmp24,"tmp24");
								HX_STACK_LINE(417)
								Float tmp25 = (tmp23 + tmp24);		HX_STACK_VAR(tmp25,"tmp25");
								HX_STACK_LINE(417)
								Float PivotY = tmp25;		HX_STACK_VAR(PivotY,"PivotY");
								HX_STACK_LINE(417)
								::flixel::util::FlxPoint point = Point;		HX_STACK_VAR(point,"point");
								HX_STACK_LINE(417)
								Float sin = (int)0;		HX_STACK_VAR(sin,"sin");
								HX_STACK_LINE(417)
								Float cos = (int)0;		HX_STACK_VAR(cos,"cos");
								HX_STACK_LINE(417)
								Float tmp26 = (Sprite->angle - (int)180);		HX_STACK_VAR(tmp26,"tmp26");
								HX_STACK_LINE(417)
								Float tmp27 = ::Math_obj::PI;		HX_STACK_VAR(tmp27,"tmp27");
								HX_STACK_LINE(417)
								Float tmp28 = (Float(tmp27) / Float((int)180));		HX_STACK_VAR(tmp28,"tmp28");
								HX_STACK_LINE(417)
								Float tmp29 = -(tmp28);		HX_STACK_VAR(tmp29,"tmp29");
								HX_STACK_LINE(417)
								Float tmp30 = (tmp26 * tmp29);		HX_STACK_VAR(tmp30,"tmp30");
								HX_STACK_LINE(417)
								Float radians = tmp30;		HX_STACK_VAR(radians,"radians");
								HX_STACK_LINE(417)
								while((true)){
									HX_STACK_LINE(417)
									Float tmp31 = radians;		HX_STACK_VAR(tmp31,"tmp31");
									HX_STACK_LINE(417)
									Float tmp32 = ::Math_obj::PI;		HX_STACK_VAR(tmp32,"tmp32");
									HX_STACK_LINE(417)
									Float tmp33 = -(tmp32);		HX_STACK_VAR(tmp33,"tmp33");
									HX_STACK_LINE(417)
									bool tmp34 = (tmp31 < tmp33);		HX_STACK_VAR(tmp34,"tmp34");
									HX_STACK_LINE(417)
									bool tmp35 = !(tmp34);		HX_STACK_VAR(tmp35,"tmp35");
									HX_STACK_LINE(417)
									if ((tmp35)){
										HX_STACK_LINE(417)
										break;
									}
									HX_STACK_LINE(417)
									Float tmp36 = ::Math_obj::PI;		HX_STACK_VAR(tmp36,"tmp36");
									HX_STACK_LINE(417)
									Float tmp37 = (tmp36 * (int)2);		HX_STACK_VAR(tmp37,"tmp37");
									HX_STACK_LINE(417)
									hx::AddEq(radians,tmp37);
								}
								HX_STACK_LINE(417)
								while((true)){
									HX_STACK_LINE(417)
									Float tmp31 = radians;		HX_STACK_VAR(tmp31,"tmp31");
									HX_STACK_LINE(417)
									Float tmp32 = ::Math_obj::PI;		HX_STACK_VAR(tmp32,"tmp32");
									HX_STACK_LINE(417)
									bool tmp33 = (tmp31 > tmp32);		HX_STACK_VAR(tmp33,"tmp33");
									HX_STACK_LINE(417)
									bool tmp34 = !(tmp33);		HX_STACK_VAR(tmp34,"tmp34");
									HX_STACK_LINE(417)
									if ((tmp34)){
										HX_STACK_LINE(417)
										break;
									}
									HX_STACK_LINE(417)
									Float tmp35 = radians;		HX_STACK_VAR(tmp35,"tmp35");
									HX_STACK_LINE(417)
									Float tmp36 = ::Math_obj::PI;		HX_STACK_VAR(tmp36,"tmp36");
									HX_STACK_LINE(417)
									Float tmp37 = (tmp36 * (int)2);		HX_STACK_VAR(tmp37,"tmp37");
									HX_STACK_LINE(417)
									Float tmp38 = (tmp35 - tmp37);		HX_STACK_VAR(tmp38,"tmp38");
									HX_STACK_LINE(417)
									radians = tmp38;
								}
								HX_STACK_LINE(417)
								bool tmp31 = (radians < (int)0);		HX_STACK_VAR(tmp31,"tmp31");
								HX_STACK_LINE(417)
								if ((tmp31)){
									HX_STACK_LINE(417)
									Float tmp32 = (((Float)1.27323954) * radians);		HX_STACK_VAR(tmp32,"tmp32");
									HX_STACK_LINE(417)
									Float tmp33 = (((Float).405284735) * radians);		HX_STACK_VAR(tmp33,"tmp33");
									HX_STACK_LINE(417)
									Float tmp34 = radians;		HX_STACK_VAR(tmp34,"tmp34");
									HX_STACK_LINE(417)
									Float tmp35 = (tmp33 * tmp34);		HX_STACK_VAR(tmp35,"tmp35");
									HX_STACK_LINE(417)
									Float tmp36 = (tmp32 + tmp35);		HX_STACK_VAR(tmp36,"tmp36");
									HX_STACK_LINE(417)
									sin = tmp36;
									HX_STACK_LINE(417)
									bool tmp37 = (sin < (int)0);		HX_STACK_VAR(tmp37,"tmp37");
									HX_STACK_LINE(417)
									if ((tmp37)){
										HX_STACK_LINE(417)
										Float tmp38 = sin;		HX_STACK_VAR(tmp38,"tmp38");
										HX_STACK_LINE(417)
										Float tmp39 = sin;		HX_STACK_VAR(tmp39,"tmp39");
										HX_STACK_LINE(417)
										Float tmp40 = -(tmp39);		HX_STACK_VAR(tmp40,"tmp40");
										HX_STACK_LINE(417)
										Float tmp41 = (tmp38 * tmp40);		HX_STACK_VAR(tmp41,"tmp41");
										HX_STACK_LINE(417)
										Float tmp42 = sin;		HX_STACK_VAR(tmp42,"tmp42");
										HX_STACK_LINE(417)
										Float tmp43 = (tmp41 - tmp42);		HX_STACK_VAR(tmp43,"tmp43");
										HX_STACK_LINE(417)
										Float tmp44 = (((Float).225) * tmp43);		HX_STACK_VAR(tmp44,"tmp44");
										HX_STACK_LINE(417)
										Float tmp45 = sin;		HX_STACK_VAR(tmp45,"tmp45");
										HX_STACK_LINE(417)
										Float tmp46 = (tmp44 + tmp45);		HX_STACK_VAR(tmp46,"tmp46");
										HX_STACK_LINE(417)
										sin = tmp46;
									}
									else{
										HX_STACK_LINE(417)
										Float tmp38 = (sin * sin);		HX_STACK_VAR(tmp38,"tmp38");
										HX_STACK_LINE(417)
										Float tmp39 = sin;		HX_STACK_VAR(tmp39,"tmp39");
										HX_STACK_LINE(417)
										Float tmp40 = (tmp38 - tmp39);		HX_STACK_VAR(tmp40,"tmp40");
										HX_STACK_LINE(417)
										Float tmp41 = (((Float).225) * tmp40);		HX_STACK_VAR(tmp41,"tmp41");
										HX_STACK_LINE(417)
										Float tmp42 = sin;		HX_STACK_VAR(tmp42,"tmp42");
										HX_STACK_LINE(417)
										Float tmp43 = (tmp41 + tmp42);		HX_STACK_VAR(tmp43,"tmp43");
										HX_STACK_LINE(417)
										sin = tmp43;
									}
								}
								else{
									HX_STACK_LINE(417)
									Float tmp32 = (((Float)1.27323954) * radians);		HX_STACK_VAR(tmp32,"tmp32");
									HX_STACK_LINE(417)
									Float tmp33 = (((Float)0.405284735) * radians);		HX_STACK_VAR(tmp33,"tmp33");
									HX_STACK_LINE(417)
									Float tmp34 = radians;		HX_STACK_VAR(tmp34,"tmp34");
									HX_STACK_LINE(417)
									Float tmp35 = (tmp33 * tmp34);		HX_STACK_VAR(tmp35,"tmp35");
									HX_STACK_LINE(417)
									Float tmp36 = (tmp32 - tmp35);		HX_STACK_VAR(tmp36,"tmp36");
									HX_STACK_LINE(417)
									sin = tmp36;
									HX_STACK_LINE(417)
									bool tmp37 = (sin < (int)0);		HX_STACK_VAR(tmp37,"tmp37");
									HX_STACK_LINE(417)
									if ((tmp37)){
										HX_STACK_LINE(417)
										Float tmp38 = sin;		HX_STACK_VAR(tmp38,"tmp38");
										HX_STACK_LINE(417)
										Float tmp39 = sin;		HX_STACK_VAR(tmp39,"tmp39");
										HX_STACK_LINE(417)
										Float tmp40 = -(tmp39);		HX_STACK_VAR(tmp40,"tmp40");
										HX_STACK_LINE(417)
										Float tmp41 = (tmp38 * tmp40);		HX_STACK_VAR(tmp41,"tmp41");
										HX_STACK_LINE(417)
										Float tmp42 = sin;		HX_STACK_VAR(tmp42,"tmp42");
										HX_STACK_LINE(417)
										Float tmp43 = (tmp41 - tmp42);		HX_STACK_VAR(tmp43,"tmp43");
										HX_STACK_LINE(417)
										Float tmp44 = (((Float).225) * tmp43);		HX_STACK_VAR(tmp44,"tmp44");
										HX_STACK_LINE(417)
										Float tmp45 = sin;		HX_STACK_VAR(tmp45,"tmp45");
										HX_STACK_LINE(417)
										Float tmp46 = (tmp44 + tmp45);		HX_STACK_VAR(tmp46,"tmp46");
										HX_STACK_LINE(417)
										sin = tmp46;
									}
									else{
										HX_STACK_LINE(417)
										Float tmp38 = (sin * sin);		HX_STACK_VAR(tmp38,"tmp38");
										HX_STACK_LINE(417)
										Float tmp39 = sin;		HX_STACK_VAR(tmp39,"tmp39");
										HX_STACK_LINE(417)
										Float tmp40 = (tmp38 - tmp39);		HX_STACK_VAR(tmp40,"tmp40");
										HX_STACK_LINE(417)
										Float tmp41 = (((Float).225) * tmp40);		HX_STACK_VAR(tmp41,"tmp41");
										HX_STACK_LINE(417)
										Float tmp42 = sin;		HX_STACK_VAR(tmp42,"tmp42");
										HX_STACK_LINE(417)
										Float tmp43 = (tmp41 + tmp42);		HX_STACK_VAR(tmp43,"tmp43");
										HX_STACK_LINE(417)
										sin = tmp43;
									}
								}
								HX_STACK_LINE(417)
								Float tmp32 = ::Math_obj::PI;		HX_STACK_VAR(tmp32,"tmp32");
								HX_STACK_LINE(417)
								Float tmp33 = (Float(tmp32) / Float((int)2));		HX_STACK_VAR(tmp33,"tmp33");
								HX_STACK_LINE(417)
								hx::AddEq(radians,tmp33);
								HX_STACK_LINE(417)
								Float tmp34 = radians;		HX_STACK_VAR(tmp34,"tmp34");
								HX_STACK_LINE(417)
								Float tmp35 = ::Math_obj::PI;		HX_STACK_VAR(tmp35,"tmp35");
								HX_STACK_LINE(417)
								bool tmp36 = (tmp34 > tmp35);		HX_STACK_VAR(tmp36,"tmp36");
								HX_STACK_LINE(417)
								if ((tmp36)){
									HX_STACK_LINE(417)
									Float tmp37 = radians;		HX_STACK_VAR(tmp37,"tmp37");
									HX_STACK_LINE(417)
									Float tmp38 = ::Math_obj::PI;		HX_STACK_VAR(tmp38,"tmp38");
									HX_STACK_LINE(417)
									Float tmp39 = (tmp38 * (int)2);		HX_STACK_VAR(tmp39,"tmp39");
									HX_STACK_LINE(417)
									Float tmp40 = (tmp37 - tmp39);		HX_STACK_VAR(tmp40,"tmp40");
									HX_STACK_LINE(417)
									radians = tmp40;
								}
								HX_STACK_LINE(417)
								bool tmp37 = (radians < (int)0);		HX_STACK_VAR(tmp37,"tmp37");
								HX_STACK_LINE(417)
								if ((tmp37)){
									HX_STACK_LINE(417)
									Float tmp38 = (((Float)1.27323954) * radians);		HX_STACK_VAR(tmp38,"tmp38");
									HX_STACK_LINE(417)
									Float tmp39 = (((Float)0.405284735) * radians);		HX_STACK_VAR(tmp39,"tmp39");
									HX_STACK_LINE(417)
									Float tmp40 = radians;		HX_STACK_VAR(tmp40,"tmp40");
									HX_STACK_LINE(417)
									Float tmp41 = (tmp39 * tmp40);		HX_STACK_VAR(tmp41,"tmp41");
									HX_STACK_LINE(417)
									Float tmp42 = (tmp38 + tmp41);		HX_STACK_VAR(tmp42,"tmp42");
									HX_STACK_LINE(417)
									cos = tmp42;
									HX_STACK_LINE(417)
									bool tmp43 = (cos < (int)0);		HX_STACK_VAR(tmp43,"tmp43");
									HX_STACK_LINE(417)
									if ((tmp43)){
										HX_STACK_LINE(417)
										Float tmp44 = cos;		HX_STACK_VAR(tmp44,"tmp44");
										HX_STACK_LINE(417)
										Float tmp45 = cos;		HX_STACK_VAR(tmp45,"tmp45");
										HX_STACK_LINE(417)
										Float tmp46 = -(tmp45);		HX_STACK_VAR(tmp46,"tmp46");
										HX_STACK_LINE(417)
										Float tmp47 = (tmp44 * tmp46);		HX_STACK_VAR(tmp47,"tmp47");
										HX_STACK_LINE(417)
										Float tmp48 = cos;		HX_STACK_VAR(tmp48,"tmp48");
										HX_STACK_LINE(417)
										Float tmp49 = (tmp47 - tmp48);		HX_STACK_VAR(tmp49,"tmp49");
										HX_STACK_LINE(417)
										Float tmp50 = (((Float).225) * tmp49);		HX_STACK_VAR(tmp50,"tmp50");
										HX_STACK_LINE(417)
										Float tmp51 = cos;		HX_STACK_VAR(tmp51,"tmp51");
										HX_STACK_LINE(417)
										Float tmp52 = (tmp50 + tmp51);		HX_STACK_VAR(tmp52,"tmp52");
										HX_STACK_LINE(417)
										cos = tmp52;
									}
									else{
										HX_STACK_LINE(417)
										Float tmp44 = (cos * cos);		HX_STACK_VAR(tmp44,"tmp44");
										HX_STACK_LINE(417)
										Float tmp45 = cos;		HX_STACK_VAR(tmp45,"tmp45");
										HX_STACK_LINE(417)
										Float tmp46 = (tmp44 - tmp45);		HX_STACK_VAR(tmp46,"tmp46");
										HX_STACK_LINE(417)
										Float tmp47 = (((Float).225) * tmp46);		HX_STACK_VAR(tmp47,"tmp47");
										HX_STACK_LINE(417)
										Float tmp48 = cos;		HX_STACK_VAR(tmp48,"tmp48");
										HX_STACK_LINE(417)
										Float tmp49 = (tmp47 + tmp48);		HX_STACK_VAR(tmp49,"tmp49");
										HX_STACK_LINE(417)
										cos = tmp49;
									}
								}
								else{
									HX_STACK_LINE(417)
									Float tmp38 = (((Float)1.27323954) * radians);		HX_STACK_VAR(tmp38,"tmp38");
									HX_STACK_LINE(417)
									Float tmp39 = (((Float)0.405284735) * radians);		HX_STACK_VAR(tmp39,"tmp39");
									HX_STACK_LINE(417)
									Float tmp40 = radians;		HX_STACK_VAR(tmp40,"tmp40");
									HX_STACK_LINE(417)
									Float tmp41 = (tmp39 * tmp40);		HX_STACK_VAR(tmp41,"tmp41");
									HX_STACK_LINE(417)
									Float tmp42 = (tmp38 - tmp41);		HX_STACK_VAR(tmp42,"tmp42");
									HX_STACK_LINE(417)
									cos = tmp42;
									HX_STACK_LINE(417)
									bool tmp43 = (cos < (int)0);		HX_STACK_VAR(tmp43,"tmp43");
									HX_STACK_LINE(417)
									if ((tmp43)){
										HX_STACK_LINE(417)
										Float tmp44 = cos;		HX_STACK_VAR(tmp44,"tmp44");
										HX_STACK_LINE(417)
										Float tmp45 = cos;		HX_STACK_VAR(tmp45,"tmp45");
										HX_STACK_LINE(417)
										Float tmp46 = -(tmp45);		HX_STACK_VAR(tmp46,"tmp46");
										HX_STACK_LINE(417)
										Float tmp47 = (tmp44 * tmp46);		HX_STACK_VAR(tmp47,"tmp47");
										HX_STACK_LINE(417)
										Float tmp48 = cos;		HX_STACK_VAR(tmp48,"tmp48");
										HX_STACK_LINE(417)
										Float tmp49 = (tmp47 - tmp48);		HX_STACK_VAR(tmp49,"tmp49");
										HX_STACK_LINE(417)
										Float tmp50 = (((Float).225) * tmp49);		HX_STACK_VAR(tmp50,"tmp50");
										HX_STACK_LINE(417)
										Float tmp51 = cos;		HX_STACK_VAR(tmp51,"tmp51");
										HX_STACK_LINE(417)
										Float tmp52 = (tmp50 + tmp51);		HX_STACK_VAR(tmp52,"tmp52");
										HX_STACK_LINE(417)
										cos = tmp52;
									}
									else{
										HX_STACK_LINE(417)
										Float tmp44 = (cos * cos);		HX_STACK_VAR(tmp44,"tmp44");
										HX_STACK_LINE(417)
										Float tmp45 = cos;		HX_STACK_VAR(tmp45,"tmp45");
										HX_STACK_LINE(417)
										Float tmp46 = (tmp44 - tmp45);		HX_STACK_VAR(tmp46,"tmp46");
										HX_STACK_LINE(417)
										Float tmp47 = (((Float).225) * tmp46);		HX_STACK_VAR(tmp47,"tmp47");
										HX_STACK_LINE(417)
										Float tmp48 = cos;		HX_STACK_VAR(tmp48,"tmp48");
										HX_STACK_LINE(417)
										Float tmp49 = (tmp47 + tmp48);		HX_STACK_VAR(tmp49,"tmp49");
										HX_STACK_LINE(417)
										cos = tmp49;
									}
								}
								HX_STACK_LINE(417)
								Float tmp38 = (Point->x - PivotX);		HX_STACK_VAR(tmp38,"tmp38");
								HX_STACK_LINE(417)
								Float dx = tmp38;		HX_STACK_VAR(dx,"dx");
								HX_STACK_LINE(417)
								Float tmp39 = (Point->y - PivotY);		HX_STACK_VAR(tmp39,"tmp39");
								HX_STACK_LINE(417)
								Float dy = tmp39;		HX_STACK_VAR(dy,"dy");
								HX_STACK_LINE(417)
								bool tmp40 = (point == null());		HX_STACK_VAR(tmp40,"tmp40");
								HX_STACK_LINE(417)
								if ((tmp40)){
									HX_STACK_LINE(417)
									::flixel::util::FlxPoint tmp41;		HX_STACK_VAR(tmp41,"tmp41");
									HX_STACK_LINE(417)
									{
										HX_STACK_LINE(417)
										Float X = (int)0;		HX_STACK_VAR(X,"X");
										HX_STACK_LINE(417)
										Float Y = (int)0;		HX_STACK_VAR(Y,"Y");
										HX_STACK_LINE(417)
										::flixel::util::FlxPool tmp42 = ::flixel::util::FlxPoint_obj::_pool;		HX_STACK_VAR(tmp42,"tmp42");
										HX_STACK_LINE(417)
										::flixel::util::FlxPoint tmp43 = tmp42->get();		HX_STACK_VAR(tmp43,"tmp43");
										HX_STACK_LINE(417)
										Float tmp44 = X;		HX_STACK_VAR(tmp44,"tmp44");
										HX_STACK_LINE(417)
										Float tmp45 = Y;		HX_STACK_VAR(tmp45,"tmp45");
										HX_STACK_LINE(417)
										::flixel::util::FlxPoint tmp46 = tmp43->set(tmp44,tmp45);		HX_STACK_VAR(tmp46,"tmp46");
										HX_STACK_LINE(417)
										::flixel::util::FlxPoint point1 = tmp46;		HX_STACK_VAR(point1,"point1");
										HX_STACK_LINE(417)
										point1->_inPool = false;
										HX_STACK_LINE(417)
										tmp41 = point1;
									}
									HX_STACK_LINE(417)
									point = tmp41;
								}
								HX_STACK_LINE(417)
								Float tmp41 = PivotX;		HX_STACK_VAR(tmp41,"tmp41");
								HX_STACK_LINE(417)
								Float tmp42 = (cos * dx);		HX_STACK_VAR(tmp42,"tmp42");
								HX_STACK_LINE(417)
								Float tmp43 = (tmp41 + tmp42);		HX_STACK_VAR(tmp43,"tmp43");
								HX_STACK_LINE(417)
								Float tmp44 = (sin * dy);		HX_STACK_VAR(tmp44,"tmp44");
								HX_STACK_LINE(417)
								Float tmp45 = (tmp43 - tmp44);		HX_STACK_VAR(tmp45,"tmp45");
								HX_STACK_LINE(417)
								point->set_x(tmp45);
								HX_STACK_LINE(417)
								Float tmp46 = PivotY;		HX_STACK_VAR(tmp46,"tmp46");
								HX_STACK_LINE(417)
								Float tmp47 = (sin * dx);		HX_STACK_VAR(tmp47,"tmp47");
								HX_STACK_LINE(417)
								Float tmp48 = (tmp46 - tmp47);		HX_STACK_VAR(tmp48,"tmp48");
								HX_STACK_LINE(417)
								Float tmp49 = (cos * dy);		HX_STACK_VAR(tmp49,"tmp49");
								HX_STACK_LINE(417)
								Float tmp50 = (tmp48 - tmp49);		HX_STACK_VAR(tmp50,"tmp50");
								HX_STACK_LINE(417)
								point->set_y(tmp50);
								HX_STACK_LINE(417)
								point;
							}
							HX_STACK_LINE(417)
							::flixel::util::FlxPoint tmp20 = Point;		HX_STACK_VAR(tmp20,"tmp20");
							HX_STACK_LINE(417)
							::flixel::FlxCamera tmp21 = camera;		HX_STACK_VAR(tmp21,"tmp21");
							HX_STACK_LINE(417)
							tmp15 = Sprite->pixelsOverlapPoint(tmp20,(int)1,tmp21);
						}
						else{
							HX_STACK_LINE(417)
							::flixel::util::FlxPoint tmp19 = Point;		HX_STACK_VAR(tmp19,"tmp19");
							HX_STACK_LINE(417)
							::flixel::FlxCamera tmp20 = camera;		HX_STACK_VAR(tmp20,"tmp20");
							HX_STACK_LINE(417)
							tmp15 = Register->object->overlapsPoint(tmp19,true,tmp20);
						}
					}
					HX_STACK_LINE(417)
					if ((tmp15)){
						HX_STACK_LINE(419)
						return true;
					}
				}
			}
		}
	}
	HX_STACK_LINE(425)
	return false;
}


HX_DEFINE_DYNAMIC_FUNC1(MouseEventManager_obj,checkOverlap,return )

bool MouseEventManager_obj::checkOverlapWithPoint( ::flixel::plugin::_MouseEventManager::ObjectMouseData Register,::flixel::util::FlxPoint Point,::flixel::FlxCamera Camera){
	HX_STACK_FRAME("flixel.plugin.MouseEventManager","checkOverlapWithPoint",0x6cf1fc0c,"flixel.plugin.MouseEventManager.checkOverlapWithPoint","flixel/plugin/MouseEventManager.hx",429,0x4767214f)
	HX_STACK_THIS(this)
	HX_STACK_ARG(Register,"Register")
	HX_STACK_ARG(Point,"Point")
	HX_STACK_ARG(Camera,"Camera")
	HX_STACK_LINE(430)
	bool tmp = Register->pixelPerfect;		HX_STACK_VAR(tmp,"tmp");
	HX_STACK_LINE(430)
	bool tmp1;		HX_STACK_VAR(tmp1,"tmp1");
	HX_STACK_LINE(430)
	if ((tmp)){
		HX_STACK_LINE(430)
		tmp1 = (Register->sprite != null());
	}
	else{
		HX_STACK_LINE(430)
		tmp1 = false;
	}
	HX_STACK_LINE(430)
	if ((tmp1)){
		HX_STACK_LINE(432)
		bool tmp2;		HX_STACK_VAR(tmp2,"tmp2");
		HX_STACK_LINE(432)
		{
			HX_STACK_LINE(432)
			::flixel::FlxSprite Sprite = Register->sprite;		HX_STACK_VAR(Sprite,"Sprite");
			HX_STACK_LINE(432)
			bool tmp3 = (Sprite->angle != (int)0);		HX_STACK_VAR(tmp3,"tmp3");
			HX_STACK_LINE(432)
			if ((tmp3)){
				HX_STACK_LINE(432)
				Float tmp4 = Sprite->x;		HX_STACK_VAR(tmp4,"tmp4");
				HX_STACK_LINE(432)
				Float tmp5 = Sprite->origin->x;		HX_STACK_VAR(tmp5,"tmp5");
				HX_STACK_LINE(432)
				Float tmp6 = (tmp4 + tmp5);		HX_STACK_VAR(tmp6,"tmp6");
				HX_STACK_LINE(432)
				Float PivotX = tmp6;		HX_STACK_VAR(PivotX,"PivotX");
				HX_STACK_LINE(432)
				Float tmp7 = Sprite->y;		HX_STACK_VAR(tmp7,"tmp7");
				HX_STACK_LINE(432)
				Float tmp8 = Sprite->origin->y;		HX_STACK_VAR(tmp8,"tmp8");
				HX_STACK_LINE(432)
				Float tmp9 = (tmp7 + tmp8);		HX_STACK_VAR(tmp9,"tmp9");
				HX_STACK_LINE(432)
				Float PivotY = tmp9;		HX_STACK_VAR(PivotY,"PivotY");
				HX_STACK_LINE(432)
				::flixel::util::FlxPoint point = Point;		HX_STACK_VAR(point,"point");
				HX_STACK_LINE(432)
				Float sin = (int)0;		HX_STACK_VAR(sin,"sin");
				HX_STACK_LINE(432)
				Float cos = (int)0;		HX_STACK_VAR(cos,"cos");
				HX_STACK_LINE(432)
				Float tmp10 = (Sprite->angle - (int)180);		HX_STACK_VAR(tmp10,"tmp10");
				HX_STACK_LINE(432)
				Float tmp11 = ::Math_obj::PI;		HX_STACK_VAR(tmp11,"tmp11");
				HX_STACK_LINE(432)
				Float tmp12 = (Float(tmp11) / Float((int)180));		HX_STACK_VAR(tmp12,"tmp12");
				HX_STACK_LINE(432)
				Float tmp13 = -(tmp12);		HX_STACK_VAR(tmp13,"tmp13");
				HX_STACK_LINE(432)
				Float tmp14 = (tmp10 * tmp13);		HX_STACK_VAR(tmp14,"tmp14");
				HX_STACK_LINE(432)
				Float radians = tmp14;		HX_STACK_VAR(radians,"radians");
				HX_STACK_LINE(432)
				while((true)){
					HX_STACK_LINE(432)
					Float tmp15 = radians;		HX_STACK_VAR(tmp15,"tmp15");
					HX_STACK_LINE(432)
					Float tmp16 = ::Math_obj::PI;		HX_STACK_VAR(tmp16,"tmp16");
					HX_STACK_LINE(432)
					Float tmp17 = -(tmp16);		HX_STACK_VAR(tmp17,"tmp17");
					HX_STACK_LINE(432)
					bool tmp18 = (tmp15 < tmp17);		HX_STACK_VAR(tmp18,"tmp18");
					HX_STACK_LINE(432)
					bool tmp19 = !(tmp18);		HX_STACK_VAR(tmp19,"tmp19");
					HX_STACK_LINE(432)
					if ((tmp19)){
						HX_STACK_LINE(432)
						break;
					}
					HX_STACK_LINE(432)
					Float tmp20 = ::Math_obj::PI;		HX_STACK_VAR(tmp20,"tmp20");
					HX_STACK_LINE(432)
					Float tmp21 = (tmp20 * (int)2);		HX_STACK_VAR(tmp21,"tmp21");
					HX_STACK_LINE(432)
					hx::AddEq(radians,tmp21);
				}
				HX_STACK_LINE(432)
				while((true)){
					HX_STACK_LINE(432)
					Float tmp15 = radians;		HX_STACK_VAR(tmp15,"tmp15");
					HX_STACK_LINE(432)
					Float tmp16 = ::Math_obj::PI;		HX_STACK_VAR(tmp16,"tmp16");
					HX_STACK_LINE(432)
					bool tmp17 = (tmp15 > tmp16);		HX_STACK_VAR(tmp17,"tmp17");
					HX_STACK_LINE(432)
					bool tmp18 = !(tmp17);		HX_STACK_VAR(tmp18,"tmp18");
					HX_STACK_LINE(432)
					if ((tmp18)){
						HX_STACK_LINE(432)
						break;
					}
					HX_STACK_LINE(432)
					Float tmp19 = radians;		HX_STACK_VAR(tmp19,"tmp19");
					HX_STACK_LINE(432)
					Float tmp20 = ::Math_obj::PI;		HX_STACK_VAR(tmp20,"tmp20");
					HX_STACK_LINE(432)
					Float tmp21 = (tmp20 * (int)2);		HX_STACK_VAR(tmp21,"tmp21");
					HX_STACK_LINE(432)
					Float tmp22 = (tmp19 - tmp21);		HX_STACK_VAR(tmp22,"tmp22");
					HX_STACK_LINE(432)
					radians = tmp22;
				}
				HX_STACK_LINE(432)
				bool tmp15 = (radians < (int)0);		HX_STACK_VAR(tmp15,"tmp15");
				HX_STACK_LINE(432)
				if ((tmp15)){
					HX_STACK_LINE(432)
					Float tmp16 = (((Float)1.27323954) * radians);		HX_STACK_VAR(tmp16,"tmp16");
					HX_STACK_LINE(432)
					Float tmp17 = (((Float).405284735) * radians);		HX_STACK_VAR(tmp17,"tmp17");
					HX_STACK_LINE(432)
					Float tmp18 = radians;		HX_STACK_VAR(tmp18,"tmp18");
					HX_STACK_LINE(432)
					Float tmp19 = (tmp17 * tmp18);		HX_STACK_VAR(tmp19,"tmp19");
					HX_STACK_LINE(432)
					Float tmp20 = (tmp16 + tmp19);		HX_STACK_VAR(tmp20,"tmp20");
					HX_STACK_LINE(432)
					sin = tmp20;
					HX_STACK_LINE(432)
					bool tmp21 = (sin < (int)0);		HX_STACK_VAR(tmp21,"tmp21");
					HX_STACK_LINE(432)
					if ((tmp21)){
						HX_STACK_LINE(432)
						Float tmp22 = sin;		HX_STACK_VAR(tmp22,"tmp22");
						HX_STACK_LINE(432)
						Float tmp23 = sin;		HX_STACK_VAR(tmp23,"tmp23");
						HX_STACK_LINE(432)
						Float tmp24 = -(tmp23);		HX_STACK_VAR(tmp24,"tmp24");
						HX_STACK_LINE(432)
						Float tmp25 = (tmp22 * tmp24);		HX_STACK_VAR(tmp25,"tmp25");
						HX_STACK_LINE(432)
						Float tmp26 = sin;		HX_STACK_VAR(tmp26,"tmp26");
						HX_STACK_LINE(432)
						Float tmp27 = (tmp25 - tmp26);		HX_STACK_VAR(tmp27,"tmp27");
						HX_STACK_LINE(432)
						Float tmp28 = (((Float).225) * tmp27);		HX_STACK_VAR(tmp28,"tmp28");
						HX_STACK_LINE(432)
						Float tmp29 = sin;		HX_STACK_VAR(tmp29,"tmp29");
						HX_STACK_LINE(432)
						Float tmp30 = (tmp28 + tmp29);		HX_STACK_VAR(tmp30,"tmp30");
						HX_STACK_LINE(432)
						sin = tmp30;
					}
					else{
						HX_STACK_LINE(432)
						Float tmp22 = (sin * sin);		HX_STACK_VAR(tmp22,"tmp22");
						HX_STACK_LINE(432)
						Float tmp23 = sin;		HX_STACK_VAR(tmp23,"tmp23");
						HX_STACK_LINE(432)
						Float tmp24 = (tmp22 - tmp23);		HX_STACK_VAR(tmp24,"tmp24");
						HX_STACK_LINE(432)
						Float tmp25 = (((Float).225) * tmp24);		HX_STACK_VAR(tmp25,"tmp25");
						HX_STACK_LINE(432)
						Float tmp26 = sin;		HX_STACK_VAR(tmp26,"tmp26");
						HX_STACK_LINE(432)
						Float tmp27 = (tmp25 + tmp26);		HX_STACK_VAR(tmp27,"tmp27");
						HX_STACK_LINE(432)
						sin = tmp27;
					}
				}
				else{
					HX_STACK_LINE(432)
					Float tmp16 = (((Float)1.27323954) * radians);		HX_STACK_VAR(tmp16,"tmp16");
					HX_STACK_LINE(432)
					Float tmp17 = (((Float)0.405284735) * radians);		HX_STACK_VAR(tmp17,"tmp17");
					HX_STACK_LINE(432)
					Float tmp18 = radians;		HX_STACK_VAR(tmp18,"tmp18");
					HX_STACK_LINE(432)
					Float tmp19 = (tmp17 * tmp18);		HX_STACK_VAR(tmp19,"tmp19");
					HX_STACK_LINE(432)
					Float tmp20 = (tmp16 - tmp19);		HX_STACK_VAR(tmp20,"tmp20");
					HX_STACK_LINE(432)
					sin = tmp20;
					HX_STACK_LINE(432)
					bool tmp21 = (sin < (int)0);		HX_STACK_VAR(tmp21,"tmp21");
					HX_STACK_LINE(432)
					if ((tmp21)){
						HX_STACK_LINE(432)
						Float tmp22 = sin;		HX_STACK_VAR(tmp22,"tmp22");
						HX_STACK_LINE(432)
						Float tmp23 = sin;		HX_STACK_VAR(tmp23,"tmp23");
						HX_STACK_LINE(432)
						Float tmp24 = -(tmp23);		HX_STACK_VAR(tmp24,"tmp24");
						HX_STACK_LINE(432)
						Float tmp25 = (tmp22 * tmp24);		HX_STACK_VAR(tmp25,"tmp25");
						HX_STACK_LINE(432)
						Float tmp26 = sin;		HX_STACK_VAR(tmp26,"tmp26");
						HX_STACK_LINE(432)
						Float tmp27 = (tmp25 - tmp26);		HX_STACK_VAR(tmp27,"tmp27");
						HX_STACK_LINE(432)
						Float tmp28 = (((Float).225) * tmp27);		HX_STACK_VAR(tmp28,"tmp28");
						HX_STACK_LINE(432)
						Float tmp29 = sin;		HX_STACK_VAR(tmp29,"tmp29");
						HX_STACK_LINE(432)
						Float tmp30 = (tmp28 + tmp29);		HX_STACK_VAR(tmp30,"tmp30");
						HX_STACK_LINE(432)
						sin = tmp30;
					}
					else{
						HX_STACK_LINE(432)
						Float tmp22 = (sin * sin);		HX_STACK_VAR(tmp22,"tmp22");
						HX_STACK_LINE(432)
						Float tmp23 = sin;		HX_STACK_VAR(tmp23,"tmp23");
						HX_STACK_LINE(432)
						Float tmp24 = (tmp22 - tmp23);		HX_STACK_VAR(tmp24,"tmp24");
						HX_STACK_LINE(432)
						Float tmp25 = (((Float).225) * tmp24);		HX_STACK_VAR(tmp25,"tmp25");
						HX_STACK_LINE(432)
						Float tmp26 = sin;		HX_STACK_VAR(tmp26,"tmp26");
						HX_STACK_LINE(432)
						Float tmp27 = (tmp25 + tmp26);		HX_STACK_VAR(tmp27,"tmp27");
						HX_STACK_LINE(432)
						sin = tmp27;
					}
				}
				HX_STACK_LINE(432)
				Float tmp16 = ::Math_obj::PI;		HX_STACK_VAR(tmp16,"tmp16");
				HX_STACK_LINE(432)
				Float tmp17 = (Float(tmp16) / Float((int)2));		HX_STACK_VAR(tmp17,"tmp17");
				HX_STACK_LINE(432)
				hx::AddEq(radians,tmp17);
				HX_STACK_LINE(432)
				Float tmp18 = radians;		HX_STACK_VAR(tmp18,"tmp18");
				HX_STACK_LINE(432)
				Float tmp19 = ::Math_obj::PI;		HX_STACK_VAR(tmp19,"tmp19");
				HX_STACK_LINE(432)
				bool tmp20 = (tmp18 > tmp19);		HX_STACK_VAR(tmp20,"tmp20");
				HX_STACK_LINE(432)
				if ((tmp20)){
					HX_STACK_LINE(432)
					Float tmp21 = radians;		HX_STACK_VAR(tmp21,"tmp21");
					HX_STACK_LINE(432)
					Float tmp22 = ::Math_obj::PI;		HX_STACK_VAR(tmp22,"tmp22");
					HX_STACK_LINE(432)
					Float tmp23 = (tmp22 * (int)2);		HX_STACK_VAR(tmp23,"tmp23");
					HX_STACK_LINE(432)
					Float tmp24 = (tmp21 - tmp23);		HX_STACK_VAR(tmp24,"tmp24");
					HX_STACK_LINE(432)
					radians = tmp24;
				}
				HX_STACK_LINE(432)
				bool tmp21 = (radians < (int)0);		HX_STACK_VAR(tmp21,"tmp21");
				HX_STACK_LINE(432)
				if ((tmp21)){
					HX_STACK_LINE(432)
					Float tmp22 = (((Float)1.27323954) * radians);		HX_STACK_VAR(tmp22,"tmp22");
					HX_STACK_LINE(432)
					Float tmp23 = (((Float)0.405284735) * radians);		HX_STACK_VAR(tmp23,"tmp23");
					HX_STACK_LINE(432)
					Float tmp24 = radians;		HX_STACK_VAR(tmp24,"tmp24");
					HX_STACK_LINE(432)
					Float tmp25 = (tmp23 * tmp24);		HX_STACK_VAR(tmp25,"tmp25");
					HX_STACK_LINE(432)
					Float tmp26 = (tmp22 + tmp25);		HX_STACK_VAR(tmp26,"tmp26");
					HX_STACK_LINE(432)
					cos = tmp26;
					HX_STACK_LINE(432)
					bool tmp27 = (cos < (int)0);		HX_STACK_VAR(tmp27,"tmp27");
					HX_STACK_LINE(432)
					if ((tmp27)){
						HX_STACK_LINE(432)
						Float tmp28 = cos;		HX_STACK_VAR(tmp28,"tmp28");
						HX_STACK_LINE(432)
						Float tmp29 = cos;		HX_STACK_VAR(tmp29,"tmp29");
						HX_STACK_LINE(432)
						Float tmp30 = -(tmp29);		HX_STACK_VAR(tmp30,"tmp30");
						HX_STACK_LINE(432)
						Float tmp31 = (tmp28 * tmp30);		HX_STACK_VAR(tmp31,"tmp31");
						HX_STACK_LINE(432)
						Float tmp32 = cos;		HX_STACK_VAR(tmp32,"tmp32");
						HX_STACK_LINE(432)
						Float tmp33 = (tmp31 - tmp32);		HX_STACK_VAR(tmp33,"tmp33");
						HX_STACK_LINE(432)
						Float tmp34 = (((Float).225) * tmp33);		HX_STACK_VAR(tmp34,"tmp34");
						HX_STACK_LINE(432)
						Float tmp35 = cos;		HX_STACK_VAR(tmp35,"tmp35");
						HX_STACK_LINE(432)
						Float tmp36 = (tmp34 + tmp35);		HX_STACK_VAR(tmp36,"tmp36");
						HX_STACK_LINE(432)
						cos = tmp36;
					}
					else{
						HX_STACK_LINE(432)
						Float tmp28 = (cos * cos);		HX_STACK_VAR(tmp28,"tmp28");
						HX_STACK_LINE(432)
						Float tmp29 = cos;		HX_STACK_VAR(tmp29,"tmp29");
						HX_STACK_LINE(432)
						Float tmp30 = (tmp28 - tmp29);		HX_STACK_VAR(tmp30,"tmp30");
						HX_STACK_LINE(432)
						Float tmp31 = (((Float).225) * tmp30);		HX_STACK_VAR(tmp31,"tmp31");
						HX_STACK_LINE(432)
						Float tmp32 = cos;		HX_STACK_VAR(tmp32,"tmp32");
						HX_STACK_LINE(432)
						Float tmp33 = (tmp31 + tmp32);		HX_STACK_VAR(tmp33,"tmp33");
						HX_STACK_LINE(432)
						cos = tmp33;
					}
				}
				else{
					HX_STACK_LINE(432)
					Float tmp22 = (((Float)1.27323954) * radians);		HX_STACK_VAR(tmp22,"tmp22");
					HX_STACK_LINE(432)
					Float tmp23 = (((Float)0.405284735) * radians);		HX_STACK_VAR(tmp23,"tmp23");
					HX_STACK_LINE(432)
					Float tmp24 = radians;		HX_STACK_VAR(tmp24,"tmp24");
					HX_STACK_LINE(432)
					Float tmp25 = (tmp23 * tmp24);		HX_STACK_VAR(tmp25,"tmp25");
					HX_STACK_LINE(432)
					Float tmp26 = (tmp22 - tmp25);		HX_STACK_VAR(tmp26,"tmp26");
					HX_STACK_LINE(432)
					cos = tmp26;
					HX_STACK_LINE(432)
					bool tmp27 = (cos < (int)0);		HX_STACK_VAR(tmp27,"tmp27");
					HX_STACK_LINE(432)
					if ((tmp27)){
						HX_STACK_LINE(432)
						Float tmp28 = cos;		HX_STACK_VAR(tmp28,"tmp28");
						HX_STACK_LINE(432)
						Float tmp29 = cos;		HX_STACK_VAR(tmp29,"tmp29");
						HX_STACK_LINE(432)
						Float tmp30 = -(tmp29);		HX_STACK_VAR(tmp30,"tmp30");
						HX_STACK_LINE(432)
						Float tmp31 = (tmp28 * tmp30);		HX_STACK_VAR(tmp31,"tmp31");
						HX_STACK_LINE(432)
						Float tmp32 = cos;		HX_STACK_VAR(tmp32,"tmp32");
						HX_STACK_LINE(432)
						Float tmp33 = (tmp31 - tmp32);		HX_STACK_VAR(tmp33,"tmp33");
						HX_STACK_LINE(432)
						Float tmp34 = (((Float).225) * tmp33);		HX_STACK_VAR(tmp34,"tmp34");
						HX_STACK_LINE(432)
						Float tmp35 = cos;		HX_STACK_VAR(tmp35,"tmp35");
						HX_STACK_LINE(432)
						Float tmp36 = (tmp34 + tmp35);		HX_STACK_VAR(tmp36,"tmp36");
						HX_STACK_LINE(432)
						cos = tmp36;
					}
					else{
						HX_STACK_LINE(432)
						Float tmp28 = (cos * cos);		HX_STACK_VAR(tmp28,"tmp28");
						HX_STACK_LINE(432)
						Float tmp29 = cos;		HX_STACK_VAR(tmp29,"tmp29");
						HX_STACK_LINE(432)
						Float tmp30 = (tmp28 - tmp29);		HX_STACK_VAR(tmp30,"tmp30");
						HX_STACK_LINE(432)
						Float tmp31 = (((Float).225) * tmp30);		HX_STACK_VAR(tmp31,"tmp31");
						HX_STACK_LINE(432)
						Float tmp32 = cos;		HX_STACK_VAR(tmp32,"tmp32");
						HX_STACK_LINE(432)
						Float tmp33 = (tmp31 + tmp32);		HX_STACK_VAR(tmp33,"tmp33");
						HX_STACK_LINE(432)
						cos = tmp33;
					}
				}
				HX_STACK_LINE(432)
				Float tmp22 = (Point->x - PivotX);		HX_STACK_VAR(tmp22,"tmp22");
				HX_STACK_LINE(432)
				Float dx = tmp22;		HX_STACK_VAR(dx,"dx");
				HX_STACK_LINE(432)
				Float tmp23 = (Point->y - PivotY);		HX_STACK_VAR(tmp23,"tmp23");
				HX_STACK_LINE(432)
				Float dy = tmp23;		HX_STACK_VAR(dy,"dy");
				HX_STACK_LINE(432)
				bool tmp24 = (point == null());		HX_STACK_VAR(tmp24,"tmp24");
				HX_STACK_LINE(432)
				if ((tmp24)){
					HX_STACK_LINE(432)
					::flixel::util::FlxPoint tmp25;		HX_STACK_VAR(tmp25,"tmp25");
					HX_STACK_LINE(432)
					{
						HX_STACK_LINE(432)
						Float X = (int)0;		HX_STACK_VAR(X,"X");
						HX_STACK_LINE(432)
						Float Y = (int)0;		HX_STACK_VAR(Y,"Y");
						HX_STACK_LINE(432)
						::flixel::util::FlxPool tmp26 = ::flixel::util::FlxPoint_obj::_pool;		HX_STACK_VAR(tmp26,"tmp26");
						HX_STACK_LINE(432)
						::flixel::util::FlxPoint tmp27 = tmp26->get();		HX_STACK_VAR(tmp27,"tmp27");
						HX_STACK_LINE(432)
						Float tmp28 = X;		HX_STACK_VAR(tmp28,"tmp28");
						HX_STACK_LINE(432)
						Float tmp29 = Y;		HX_STACK_VAR(tmp29,"tmp29");
						HX_STACK_LINE(432)
						::flixel::util::FlxPoint tmp30 = tmp27->set(tmp28,tmp29);		HX_STACK_VAR(tmp30,"tmp30");
						HX_STACK_LINE(432)
						::flixel::util::FlxPoint point1 = tmp30;		HX_STACK_VAR(point1,"point1");
						HX_STACK_LINE(432)
						point1->_inPool = false;
						HX_STACK_LINE(432)
						tmp25 = point1;
					}
					HX_STACK_LINE(432)
					point = tmp25;
				}
				HX_STACK_LINE(432)
				Float tmp25 = PivotX;		HX_STACK_VAR(tmp25,"tmp25");
				HX_STACK_LINE(432)
				Float tmp26 = (cos * dx);		HX_STACK_VAR(tmp26,"tmp26");
				HX_STACK_LINE(432)
				Float tmp27 = (tmp25 + tmp26);		HX_STACK_VAR(tmp27,"tmp27");
				HX_STACK_LINE(432)
				Float tmp28 = (sin * dy);		HX_STACK_VAR(tmp28,"tmp28");
				HX_STACK_LINE(432)
				Float tmp29 = (tmp27 - tmp28);		HX_STACK_VAR(tmp29,"tmp29");
				HX_STACK_LINE(432)
				point->set_x(tmp29);
				HX_STACK_LINE(432)
				Float tmp30 = PivotY;		HX_STACK_VAR(tmp30,"tmp30");
				HX_STACK_LINE(432)
				Float tmp31 = (sin * dx);		HX_STACK_VAR(tmp31,"tmp31");
				HX_STACK_LINE(432)
				Float tmp32 = (tmp30 - tmp31);		HX_STACK_VAR(tmp32,"tmp32");
				HX_STACK_LINE(432)
				Float tmp33 = (cos * dy);		HX_STACK_VAR(tmp33,"tmp33");
				HX_STACK_LINE(432)
				Float tmp34 = (tmp32 - tmp33);		HX_STACK_VAR(tmp34,"tmp34");
				HX_STACK_LINE(432)
				point->set_y(tmp34);
				HX_STACK_LINE(432)
				point;
			}
			HX_STACK_LINE(432)
			::flixel::util::FlxPoint tmp4 = Point;		HX_STACK_VAR(tmp4,"tmp4");
			HX_STACK_LINE(432)
			::flixel::FlxCamera tmp5 = Camera;		HX_STACK_VAR(tmp5,"tmp5");
			HX_STACK_LINE(432)
			tmp2 = Sprite->pixelsOverlapPoint(tmp4,(int)1,tmp5);
		}
		HX_STACK_LINE(432)
		return tmp2;
	}
	else{
		HX_STACK_LINE(436)
		::flixel::util::FlxPoint tmp2 = Point;		HX_STACK_VAR(tmp2,"tmp2");
		HX_STACK_LINE(436)
		::flixel::FlxCamera tmp3 = Camera;		HX_STACK_VAR(tmp3,"tmp3");
		HX_STACK_LINE(436)
		bool tmp4 = Register->object->overlapsPoint(tmp2,true,tmp3);		HX_STACK_VAR(tmp4,"tmp4");
		HX_STACK_LINE(436)
		return tmp4;
	}
	HX_STACK_LINE(430)
	return false;
}


HX_DEFINE_DYNAMIC_FUNC3(MouseEventManager_obj,checkOverlapWithPoint,return )

bool MouseEventManager_obj::checkPixelPerfectOverlap( ::flixel::util::FlxPoint Point,::flixel::FlxSprite Sprite,::flixel::FlxCamera Camera){
	HX_STACK_FRAME("flixel.plugin.MouseEventManager","checkPixelPerfectOverlap",0xc22d5a97,"flixel.plugin.MouseEventManager.checkPixelPerfectOverlap","flixel/plugin/MouseEventManager.hx",441,0x4767214f)
	HX_STACK_THIS(this)
	HX_STACK_ARG(Point,"Point")
	HX_STACK_ARG(Sprite,"Sprite")
	HX_STACK_ARG(Camera,"Camera")
	HX_STACK_LINE(442)
	bool tmp = (Sprite->angle != (int)0);		HX_STACK_VAR(tmp,"tmp");
	HX_STACK_LINE(442)
	if ((tmp)){
		HX_STACK_LINE(444)
		Float tmp1 = Sprite->x;		HX_STACK_VAR(tmp1,"tmp1");
		HX_STACK_LINE(444)
		Float tmp2 = Sprite->origin->x;		HX_STACK_VAR(tmp2,"tmp2");
		HX_STACK_LINE(444)
		Float tmp3 = (tmp1 + tmp2);		HX_STACK_VAR(tmp3,"tmp3");
		HX_STACK_LINE(444)
		Float PivotX = tmp3;		HX_STACK_VAR(PivotX,"PivotX");
		HX_STACK_LINE(444)
		Float tmp4 = Sprite->y;		HX_STACK_VAR(tmp4,"tmp4");
		HX_STACK_LINE(444)
		Float tmp5 = Sprite->origin->y;		HX_STACK_VAR(tmp5,"tmp5");
		HX_STACK_LINE(444)
		Float tmp6 = (tmp4 + tmp5);		HX_STACK_VAR(tmp6,"tmp6");
		HX_STACK_LINE(444)
		Float PivotY = tmp6;		HX_STACK_VAR(PivotY,"PivotY");
		HX_STACK_LINE(444)
		::flixel::util::FlxPoint point = Point;		HX_STACK_VAR(point,"point");
		HX_STACK_LINE(444)
		Float sin = (int)0;		HX_STACK_VAR(sin,"sin");
		HX_STACK_LINE(444)
		Float cos = (int)0;		HX_STACK_VAR(cos,"cos");
		HX_STACK_LINE(444)
		Float tmp7 = (Sprite->angle - (int)180);		HX_STACK_VAR(tmp7,"tmp7");
		HX_STACK_LINE(444)
		Float tmp8 = ::Math_obj::PI;		HX_STACK_VAR(tmp8,"tmp8");
		HX_STACK_LINE(444)
		Float tmp9 = (Float(tmp8) / Float((int)180));		HX_STACK_VAR(tmp9,"tmp9");
		HX_STACK_LINE(444)
		Float tmp10 = -(tmp9);		HX_STACK_VAR(tmp10,"tmp10");
		HX_STACK_LINE(444)
		Float tmp11 = (tmp7 * tmp10);		HX_STACK_VAR(tmp11,"tmp11");
		HX_STACK_LINE(444)
		Float radians = tmp11;		HX_STACK_VAR(radians,"radians");
		HX_STACK_LINE(444)
		while((true)){
			HX_STACK_LINE(444)
			Float tmp12 = radians;		HX_STACK_VAR(tmp12,"tmp12");
			HX_STACK_LINE(444)
			Float tmp13 = ::Math_obj::PI;		HX_STACK_VAR(tmp13,"tmp13");
			HX_STACK_LINE(444)
			Float tmp14 = -(tmp13);		HX_STACK_VAR(tmp14,"tmp14");
			HX_STACK_LINE(444)
			bool tmp15 = (tmp12 < tmp14);		HX_STACK_VAR(tmp15,"tmp15");
			HX_STACK_LINE(444)
			bool tmp16 = !(tmp15);		HX_STACK_VAR(tmp16,"tmp16");
			HX_STACK_LINE(444)
			if ((tmp16)){
				HX_STACK_LINE(444)
				break;
			}
			HX_STACK_LINE(444)
			Float tmp17 = ::Math_obj::PI;		HX_STACK_VAR(tmp17,"tmp17");
			HX_STACK_LINE(444)
			Float tmp18 = (tmp17 * (int)2);		HX_STACK_VAR(tmp18,"tmp18");
			HX_STACK_LINE(444)
			hx::AddEq(radians,tmp18);
		}
		HX_STACK_LINE(444)
		while((true)){
			HX_STACK_LINE(444)
			Float tmp12 = radians;		HX_STACK_VAR(tmp12,"tmp12");
			HX_STACK_LINE(444)
			Float tmp13 = ::Math_obj::PI;		HX_STACK_VAR(tmp13,"tmp13");
			HX_STACK_LINE(444)
			bool tmp14 = (tmp12 > tmp13);		HX_STACK_VAR(tmp14,"tmp14");
			HX_STACK_LINE(444)
			bool tmp15 = !(tmp14);		HX_STACK_VAR(tmp15,"tmp15");
			HX_STACK_LINE(444)
			if ((tmp15)){
				HX_STACK_LINE(444)
				break;
			}
			HX_STACK_LINE(444)
			Float tmp16 = radians;		HX_STACK_VAR(tmp16,"tmp16");
			HX_STACK_LINE(444)
			Float tmp17 = ::Math_obj::PI;		HX_STACK_VAR(tmp17,"tmp17");
			HX_STACK_LINE(444)
			Float tmp18 = (tmp17 * (int)2);		HX_STACK_VAR(tmp18,"tmp18");
			HX_STACK_LINE(444)
			Float tmp19 = (tmp16 - tmp18);		HX_STACK_VAR(tmp19,"tmp19");
			HX_STACK_LINE(444)
			radians = tmp19;
		}
		HX_STACK_LINE(444)
		bool tmp12 = (radians < (int)0);		HX_STACK_VAR(tmp12,"tmp12");
		HX_STACK_LINE(444)
		if ((tmp12)){
			HX_STACK_LINE(444)
			Float tmp13 = (((Float)1.27323954) * radians);		HX_STACK_VAR(tmp13,"tmp13");
			HX_STACK_LINE(444)
			Float tmp14 = (((Float).405284735) * radians);		HX_STACK_VAR(tmp14,"tmp14");
			HX_STACK_LINE(444)
			Float tmp15 = radians;		HX_STACK_VAR(tmp15,"tmp15");
			HX_STACK_LINE(444)
			Float tmp16 = (tmp14 * tmp15);		HX_STACK_VAR(tmp16,"tmp16");
			HX_STACK_LINE(444)
			Float tmp17 = (tmp13 + tmp16);		HX_STACK_VAR(tmp17,"tmp17");
			HX_STACK_LINE(444)
			sin = tmp17;
			HX_STACK_LINE(444)
			bool tmp18 = (sin < (int)0);		HX_STACK_VAR(tmp18,"tmp18");
			HX_STACK_LINE(444)
			if ((tmp18)){
				HX_STACK_LINE(444)
				Float tmp19 = sin;		HX_STACK_VAR(tmp19,"tmp19");
				HX_STACK_LINE(444)
				Float tmp20 = sin;		HX_STACK_VAR(tmp20,"tmp20");
				HX_STACK_LINE(444)
				Float tmp21 = -(tmp20);		HX_STACK_VAR(tmp21,"tmp21");
				HX_STACK_LINE(444)
				Float tmp22 = (tmp19 * tmp21);		HX_STACK_VAR(tmp22,"tmp22");
				HX_STACK_LINE(444)
				Float tmp23 = sin;		HX_STACK_VAR(tmp23,"tmp23");
				HX_STACK_LINE(444)
				Float tmp24 = (tmp22 - tmp23);		HX_STACK_VAR(tmp24,"tmp24");
				HX_STACK_LINE(444)
				Float tmp25 = (((Float).225) * tmp24);		HX_STACK_VAR(tmp25,"tmp25");
				HX_STACK_LINE(444)
				Float tmp26 = sin;		HX_STACK_VAR(tmp26,"tmp26");
				HX_STACK_LINE(444)
				Float tmp27 = (tmp25 + tmp26);		HX_STACK_VAR(tmp27,"tmp27");
				HX_STACK_LINE(444)
				sin = tmp27;
			}
			else{
				HX_STACK_LINE(444)
				Float tmp19 = (sin * sin);		HX_STACK_VAR(tmp19,"tmp19");
				HX_STACK_LINE(444)
				Float tmp20 = sin;		HX_STACK_VAR(tmp20,"tmp20");
				HX_STACK_LINE(444)
				Float tmp21 = (tmp19 - tmp20);		HX_STACK_VAR(tmp21,"tmp21");
				HX_STACK_LINE(444)
				Float tmp22 = (((Float).225) * tmp21);		HX_STACK_VAR(tmp22,"tmp22");
				HX_STACK_LINE(444)
				Float tmp23 = sin;		HX_STACK_VAR(tmp23,"tmp23");
				HX_STACK_LINE(444)
				Float tmp24 = (tmp22 + tmp23);		HX_STACK_VAR(tmp24,"tmp24");
				HX_STACK_LINE(444)
				sin = tmp24;
			}
		}
		else{
			HX_STACK_LINE(444)
			Float tmp13 = (((Float)1.27323954) * radians);		HX_STACK_VAR(tmp13,"tmp13");
			HX_STACK_LINE(444)
			Float tmp14 = (((Float)0.405284735) * radians);		HX_STACK_VAR(tmp14,"tmp14");
			HX_STACK_LINE(444)
			Float tmp15 = radians;		HX_STACK_VAR(tmp15,"tmp15");
			HX_STACK_LINE(444)
			Float tmp16 = (tmp14 * tmp15);		HX_STACK_VAR(tmp16,"tmp16");
			HX_STACK_LINE(444)
			Float tmp17 = (tmp13 - tmp16);		HX_STACK_VAR(tmp17,"tmp17");
			HX_STACK_LINE(444)
			sin = tmp17;
			HX_STACK_LINE(444)
			bool tmp18 = (sin < (int)0);		HX_STACK_VAR(tmp18,"tmp18");
			HX_STACK_LINE(444)
			if ((tmp18)){
				HX_STACK_LINE(444)
				Float tmp19 = sin;		HX_STACK_VAR(tmp19,"tmp19");
				HX_STACK_LINE(444)
				Float tmp20 = sin;		HX_STACK_VAR(tmp20,"tmp20");
				HX_STACK_LINE(444)
				Float tmp21 = -(tmp20);		HX_STACK_VAR(tmp21,"tmp21");
				HX_STACK_LINE(444)
				Float tmp22 = (tmp19 * tmp21);		HX_STACK_VAR(tmp22,"tmp22");
				HX_STACK_LINE(444)
				Float tmp23 = sin;		HX_STACK_VAR(tmp23,"tmp23");
				HX_STACK_LINE(444)
				Float tmp24 = (tmp22 - tmp23);		HX_STACK_VAR(tmp24,"tmp24");
				HX_STACK_LINE(444)
				Float tmp25 = (((Float).225) * tmp24);		HX_STACK_VAR(tmp25,"tmp25");
				HX_STACK_LINE(444)
				Float tmp26 = sin;		HX_STACK_VAR(tmp26,"tmp26");
				HX_STACK_LINE(444)
				Float tmp27 = (tmp25 + tmp26);		HX_STACK_VAR(tmp27,"tmp27");
				HX_STACK_LINE(444)
				sin = tmp27;
			}
			else{
				HX_STACK_LINE(444)
				Float tmp19 = (sin * sin);		HX_STACK_VAR(tmp19,"tmp19");
				HX_STACK_LINE(444)
				Float tmp20 = sin;		HX_STACK_VAR(tmp20,"tmp20");
				HX_STACK_LINE(444)
				Float tmp21 = (tmp19 - tmp20);		HX_STACK_VAR(tmp21,"tmp21");
				HX_STACK_LINE(444)
				Float tmp22 = (((Float).225) * tmp21);		HX_STACK_VAR(tmp22,"tmp22");
				HX_STACK_LINE(444)
				Float tmp23 = sin;		HX_STACK_VAR(tmp23,"tmp23");
				HX_STACK_LINE(444)
				Float tmp24 = (tmp22 + tmp23);		HX_STACK_VAR(tmp24,"tmp24");
				HX_STACK_LINE(444)
				sin = tmp24;
			}
		}
		HX_STACK_LINE(444)
		Float tmp13 = ::Math_obj::PI;		HX_STACK_VAR(tmp13,"tmp13");
		HX_STACK_LINE(444)
		Float tmp14 = (Float(tmp13) / Float((int)2));		HX_STACK_VAR(tmp14,"tmp14");
		HX_STACK_LINE(444)
		hx::AddEq(radians,tmp14);
		HX_STACK_LINE(444)
		Float tmp15 = radians;		HX_STACK_VAR(tmp15,"tmp15");
		HX_STACK_LINE(444)
		Float tmp16 = ::Math_obj::PI;		HX_STACK_VAR(tmp16,"tmp16");
		HX_STACK_LINE(444)
		bool tmp17 = (tmp15 > tmp16);		HX_STACK_VAR(tmp17,"tmp17");
		HX_STACK_LINE(444)
		if ((tmp17)){
			HX_STACK_LINE(444)
			Float tmp18 = radians;		HX_STACK_VAR(tmp18,"tmp18");
			HX_STACK_LINE(444)
			Float tmp19 = ::Math_obj::PI;		HX_STACK_VAR(tmp19,"tmp19");
			HX_STACK_LINE(444)
			Float tmp20 = (tmp19 * (int)2);		HX_STACK_VAR(tmp20,"tmp20");
			HX_STACK_LINE(444)
			Float tmp21 = (tmp18 - tmp20);		HX_STACK_VAR(tmp21,"tmp21");
			HX_STACK_LINE(444)
			radians = tmp21;
		}
		HX_STACK_LINE(444)
		bool tmp18 = (radians < (int)0);		HX_STACK_VAR(tmp18,"tmp18");
		HX_STACK_LINE(444)
		if ((tmp18)){
			HX_STACK_LINE(444)
			Float tmp19 = (((Float)1.27323954) * radians);		HX_STACK_VAR(tmp19,"tmp19");
			HX_STACK_LINE(444)
			Float tmp20 = (((Float)0.405284735) * radians);		HX_STACK_VAR(tmp20,"tmp20");
			HX_STACK_LINE(444)
			Float tmp21 = radians;		HX_STACK_VAR(tmp21,"tmp21");
			HX_STACK_LINE(444)
			Float tmp22 = (tmp20 * tmp21);		HX_STACK_VAR(tmp22,"tmp22");
			HX_STACK_LINE(444)
			Float tmp23 = (tmp19 + tmp22);		HX_STACK_VAR(tmp23,"tmp23");
			HX_STACK_LINE(444)
			cos = tmp23;
			HX_STACK_LINE(444)
			bool tmp24 = (cos < (int)0);		HX_STACK_VAR(tmp24,"tmp24");
			HX_STACK_LINE(444)
			if ((tmp24)){
				HX_STACK_LINE(444)
				Float tmp25 = cos;		HX_STACK_VAR(tmp25,"tmp25");
				HX_STACK_LINE(444)
				Float tmp26 = cos;		HX_STACK_VAR(tmp26,"tmp26");
				HX_STACK_LINE(444)
				Float tmp27 = -(tmp26);		HX_STACK_VAR(tmp27,"tmp27");
				HX_STACK_LINE(444)
				Float tmp28 = (tmp25 * tmp27);		HX_STACK_VAR(tmp28,"tmp28");
				HX_STACK_LINE(444)
				Float tmp29 = cos;		HX_STACK_VAR(tmp29,"tmp29");
				HX_STACK_LINE(444)
				Float tmp30 = (tmp28 - tmp29);		HX_STACK_VAR(tmp30,"tmp30");
				HX_STACK_LINE(444)
				Float tmp31 = (((Float).225) * tmp30);		HX_STACK_VAR(tmp31,"tmp31");
				HX_STACK_LINE(444)
				Float tmp32 = cos;		HX_STACK_VAR(tmp32,"tmp32");
				HX_STACK_LINE(444)
				Float tmp33 = (tmp31 + tmp32);		HX_STACK_VAR(tmp33,"tmp33");
				HX_STACK_LINE(444)
				cos = tmp33;
			}
			else{
				HX_STACK_LINE(444)
				Float tmp25 = (cos * cos);		HX_STACK_VAR(tmp25,"tmp25");
				HX_STACK_LINE(444)
				Float tmp26 = cos;		HX_STACK_VAR(tmp26,"tmp26");
				HX_STACK_LINE(444)
				Float tmp27 = (tmp25 - tmp26);		HX_STACK_VAR(tmp27,"tmp27");
				HX_STACK_LINE(444)
				Float tmp28 = (((Float).225) * tmp27);		HX_STACK_VAR(tmp28,"tmp28");
				HX_STACK_LINE(444)
				Float tmp29 = cos;		HX_STACK_VAR(tmp29,"tmp29");
				HX_STACK_LINE(444)
				Float tmp30 = (tmp28 + tmp29);		HX_STACK_VAR(tmp30,"tmp30");
				HX_STACK_LINE(444)
				cos = tmp30;
			}
		}
		else{
			HX_STACK_LINE(444)
			Float tmp19 = (((Float)1.27323954) * radians);		HX_STACK_VAR(tmp19,"tmp19");
			HX_STACK_LINE(444)
			Float tmp20 = (((Float)0.405284735) * radians);		HX_STACK_VAR(tmp20,"tmp20");
			HX_STACK_LINE(444)
			Float tmp21 = radians;		HX_STACK_VAR(tmp21,"tmp21");
			HX_STACK_LINE(444)
			Float tmp22 = (tmp20 * tmp21);		HX_STACK_VAR(tmp22,"tmp22");
			HX_STACK_LINE(444)
			Float tmp23 = (tmp19 - tmp22);		HX_STACK_VAR(tmp23,"tmp23");
			HX_STACK_LINE(444)
			cos = tmp23;
			HX_STACK_LINE(444)
			bool tmp24 = (cos < (int)0);		HX_STACK_VAR(tmp24,"tmp24");
			HX_STACK_LINE(444)
			if ((tmp24)){
				HX_STACK_LINE(444)
				Float tmp25 = cos;		HX_STACK_VAR(tmp25,"tmp25");
				HX_STACK_LINE(444)
				Float tmp26 = cos;		HX_STACK_VAR(tmp26,"tmp26");
				HX_STACK_LINE(444)
				Float tmp27 = -(tmp26);		HX_STACK_VAR(tmp27,"tmp27");
				HX_STACK_LINE(444)
				Float tmp28 = (tmp25 * tmp27);		HX_STACK_VAR(tmp28,"tmp28");
				HX_STACK_LINE(444)
				Float tmp29 = cos;		HX_STACK_VAR(tmp29,"tmp29");
				HX_STACK_LINE(444)
				Float tmp30 = (tmp28 - tmp29);		HX_STACK_VAR(tmp30,"tmp30");
				HX_STACK_LINE(444)
				Float tmp31 = (((Float).225) * tmp30);		HX_STACK_VAR(tmp31,"tmp31");
				HX_STACK_LINE(444)
				Float tmp32 = cos;		HX_STACK_VAR(tmp32,"tmp32");
				HX_STACK_LINE(444)
				Float tmp33 = (tmp31 + tmp32);		HX_STACK_VAR(tmp33,"tmp33");
				HX_STACK_LINE(444)
				cos = tmp33;
			}
			else{
				HX_STACK_LINE(444)
				Float tmp25 = (cos * cos);		HX_STACK_VAR(tmp25,"tmp25");
				HX_STACK_LINE(444)
				Float tmp26 = cos;		HX_STACK_VAR(tmp26,"tmp26");
				HX_STACK_LINE(444)
				Float tmp27 = (tmp25 - tmp26);		HX_STACK_VAR(tmp27,"tmp27");
				HX_STACK_LINE(444)
				Float tmp28 = (((Float).225) * tmp27);		HX_STACK_VAR(tmp28,"tmp28");
				HX_STACK_LINE(444)
				Float tmp29 = cos;		HX_STACK_VAR(tmp29,"tmp29");
				HX_STACK_LINE(444)
				Float tmp30 = (tmp28 + tmp29);		HX_STACK_VAR(tmp30,"tmp30");
				HX_STACK_LINE(444)
				cos = tmp30;
			}
		}
		HX_STACK_LINE(444)
		Float tmp19 = (Point->x - PivotX);		HX_STACK_VAR(tmp19,"tmp19");
		HX_STACK_LINE(444)
		Float dx = tmp19;		HX_STACK_VAR(dx,"dx");
		HX_STACK_LINE(444)
		Float tmp20 = (Point->y - PivotY);		HX_STACK_VAR(tmp20,"tmp20");
		HX_STACK_LINE(444)
		Float dy = tmp20;		HX_STACK_VAR(dy,"dy");
		HX_STACK_LINE(444)
		bool tmp21 = (point == null());		HX_STACK_VAR(tmp21,"tmp21");
		HX_STACK_LINE(444)
		if ((tmp21)){
			HX_STACK_LINE(444)
			::flixel::util::FlxPoint tmp22;		HX_STACK_VAR(tmp22,"tmp22");
			HX_STACK_LINE(444)
			{
				HX_STACK_LINE(444)
				Float X = (int)0;		HX_STACK_VAR(X,"X");
				HX_STACK_LINE(444)
				Float Y = (int)0;		HX_STACK_VAR(Y,"Y");
				HX_STACK_LINE(444)
				::flixel::util::FlxPool tmp23 = ::flixel::util::FlxPoint_obj::_pool;		HX_STACK_VAR(tmp23,"tmp23");
				HX_STACK_LINE(444)
				::flixel::util::FlxPoint tmp24 = tmp23->get();		HX_STACK_VAR(tmp24,"tmp24");
				HX_STACK_LINE(444)
				Float tmp25 = X;		HX_STACK_VAR(tmp25,"tmp25");
				HX_STACK_LINE(444)
				Float tmp26 = Y;		HX_STACK_VAR(tmp26,"tmp26");
				HX_STACK_LINE(444)
				::flixel::util::FlxPoint tmp27 = tmp24->set(tmp25,tmp26);		HX_STACK_VAR(tmp27,"tmp27");
				HX_STACK_LINE(444)
				::flixel::util::FlxPoint point1 = tmp27;		HX_STACK_VAR(point1,"point1");
				HX_STACK_LINE(444)
				point1->_inPool = false;
				HX_STACK_LINE(444)
				tmp22 = point1;
			}
			HX_STACK_LINE(444)
			point = tmp22;
		}
		HX_STACK_LINE(444)
		Float tmp22 = PivotX;		HX_STACK_VAR(tmp22,"tmp22");
		HX_STACK_LINE(444)
		Float tmp23 = (cos * dx);		HX_STACK_VAR(tmp23,"tmp23");
		HX_STACK_LINE(444)
		Float tmp24 = (tmp22 + tmp23);		HX_STACK_VAR(tmp24,"tmp24");
		HX_STACK_LINE(444)
		Float tmp25 = (sin * dy);		HX_STACK_VAR(tmp25,"tmp25");
		HX_STACK_LINE(444)
		Float tmp26 = (tmp24 - tmp25);		HX_STACK_VAR(tmp26,"tmp26");
		HX_STACK_LINE(444)
		point->set_x(tmp26);
		HX_STACK_LINE(444)
		Float tmp27 = PivotY;		HX_STACK_VAR(tmp27,"tmp27");
		HX_STACK_LINE(444)
		Float tmp28 = (sin * dx);		HX_STACK_VAR(tmp28,"tmp28");
		HX_STACK_LINE(444)
		Float tmp29 = (tmp27 - tmp28);		HX_STACK_VAR(tmp29,"tmp29");
		HX_STACK_LINE(444)
		Float tmp30 = (cos * dy);		HX_STACK_VAR(tmp30,"tmp30");
		HX_STACK_LINE(444)
		Float tmp31 = (tmp29 - tmp30);		HX_STACK_VAR(tmp31,"tmp31");
		HX_STACK_LINE(444)
		point->set_y(tmp31);
		HX_STACK_LINE(444)
		point;
	}
	HX_STACK_LINE(446)
	::flixel::util::FlxPoint tmp1 = Point;		HX_STACK_VAR(tmp1,"tmp1");
	HX_STACK_LINE(446)
	::flixel::FlxCamera tmp2 = Camera;		HX_STACK_VAR(tmp2,"tmp2");
	HX_STACK_LINE(446)
	bool tmp3 = Sprite->pixelsOverlapPoint(tmp1,(int)1,tmp2);		HX_STACK_VAR(tmp3,"tmp3");
	HX_STACK_LINE(446)
	return tmp3;
}


HX_DEFINE_DYNAMIC_FUNC3(MouseEventManager_obj,checkPixelPerfectOverlap,return )

Array< ::Dynamic > MouseEventManager_obj::_registeredObjects;

Array< ::Dynamic > MouseEventManager_obj::_mouseOverObjects;

::flixel::util::FlxPoint MouseEventManager_obj::_point;

Void MouseEventManager_obj::init( ){
{
		HX_STACK_FRAME("flixel.plugin.MouseEventManager","init",0x769e44ef,"flixel.plugin.MouseEventManager.init","flixel/plugin/MouseEventManager.hx",46,0x4767214f)
		HX_STACK_LINE(47)
		::flixel::_system::frontEnds::PluginFrontEnd tmp = ::flixel::FlxG_obj::plugins;		HX_STACK_VAR(tmp,"tmp");
		HX_STACK_LINE(47)
		::flixel::plugin::FlxPlugin tmp1 = tmp->__Field(HX_HCSTRING("get","\x96","\x80","\x4e","\x00"), hx::paccDynamic )(hx::ClassOf< ::flixel::plugin::MouseEventManager >());		HX_STACK_VAR(tmp1,"tmp1");
		HX_STACK_LINE(47)
		bool tmp2 = (tmp1 == null());		HX_STACK_VAR(tmp2,"tmp2");
		HX_STACK_LINE(47)
		if ((tmp2)){
			HX_STACK_LINE(48)
			::flixel::_system::frontEnds::PluginFrontEnd tmp3 = ::flixel::FlxG_obj::plugins;		HX_STACK_VAR(tmp3,"tmp3");
			HX_STACK_LINE(48)
			::flixel::plugin::MouseEventManager tmp4 = ::flixel::plugin::MouseEventManager_obj::__new();		HX_STACK_VAR(tmp4,"tmp4");
			HX_STACK_LINE(48)
			tmp3->__Field(HX_HCSTRING("add_flixel_plugin_MouseEventManager","\x71","\xd1","\xc0","\x01"), hx::paccDynamic )(tmp4);
		}
	}
return null();
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(MouseEventManager_obj,init,(void))

Dynamic MouseEventManager_obj::add( Dynamic Object,Dynamic OnMouseDown,Dynamic OnMouseUp,Dynamic OnMouseOver,Dynamic OnMouseOut,hx::Null< bool >  __o_MouseChildren,hx::Null< bool >  __o_MouseEnabled,hx::Null< bool >  __o_PixelPerfect){
bool MouseChildren = __o_MouseChildren.Default(false);
bool MouseEnabled = __o_MouseEnabled.Default(true);
bool PixelPerfect = __o_PixelPerfect.Default(true);
	HX_STACK_FRAME("flixel.plugin.MouseEventManager","add",0x1e5b0922,"flixel.plugin.MouseEventManager.add","flixel/plugin/MouseEventManager.hx",64,0x4767214f)
	HX_STACK_ARG(Object,"Object")
	HX_STACK_ARG(OnMouseDown,"OnMouseDown")
	HX_STACK_ARG(OnMouseUp,"OnMouseUp")
	HX_STACK_ARG(OnMouseOver,"OnMouseOver")
	HX_STACK_ARG(OnMouseOut,"OnMouseOut")
	HX_STACK_ARG(MouseChildren,"MouseChildren")
	HX_STACK_ARG(MouseEnabled,"MouseEnabled")
	HX_STACK_ARG(PixelPerfect,"PixelPerfect")
{
		HX_STACK_LINE(65)
		{
			HX_STACK_LINE(65)
			::flixel::_system::frontEnds::PluginFrontEnd tmp = ::flixel::FlxG_obj::plugins;		HX_STACK_VAR(tmp,"tmp");
			HX_STACK_LINE(65)
			::flixel::plugin::FlxPlugin tmp1 = tmp->__Field(HX_HCSTRING("get","\x96","\x80","\x4e","\x00"), hx::paccDynamic )(hx::ClassOf< ::flixel::plugin::MouseEventManager >());		HX_STACK_VAR(tmp1,"tmp1");
			HX_STACK_LINE(65)
			bool tmp2 = (tmp1 == null());		HX_STACK_VAR(tmp2,"tmp2");
			HX_STACK_LINE(65)
			if ((tmp2)){
				HX_STACK_LINE(65)
				::flixel::_system::frontEnds::PluginFrontEnd tmp3 = ::flixel::FlxG_obj::plugins;		HX_STACK_VAR(tmp3,"tmp3");
				HX_STACK_LINE(65)
				::flixel::plugin::MouseEventManager tmp4 = ::flixel::plugin::MouseEventManager_obj::__new();		HX_STACK_VAR(tmp4,"tmp4");
				HX_STACK_LINE(65)
				tmp3->__Field(HX_HCSTRING("add_flixel_plugin_MouseEventManager","\x71","\xd1","\xc0","\x01"), hx::paccDynamic )(tmp4);
			}
		}
		HX_STACK_LINE(67)
		::flixel::plugin::_MouseEventManager::ObjectMouseData tmp = ::flixel::plugin::_MouseEventManager::ObjectMouseData_obj::__new(Object,OnMouseDown,OnMouseUp,OnMouseOver,OnMouseOut,MouseChildren,MouseEnabled,PixelPerfect);		HX_STACK_VAR(tmp,"tmp");
		HX_STACK_LINE(67)
		::flixel::plugin::_MouseEventManager::ObjectMouseData newReg = tmp;		HX_STACK_VAR(newReg,"newReg");
		HX_STACK_LINE(69)
		Dynamic tmp1 = Object;		HX_STACK_VAR(tmp1,"tmp1");
		HX_STACK_LINE(69)
		bool tmp2 = ::Std_obj::is(tmp1,hx::ClassOf< ::flixel::FlxSprite >());		HX_STACK_VAR(tmp2,"tmp2");
		HX_STACK_LINE(69)
		if ((tmp2)){
			HX_STACK_LINE(71)
			newReg->sprite = ((::flixel::FlxSprite)(Object));
		}
		HX_STACK_LINE(74)
		::flixel::plugin::_MouseEventManager::ObjectMouseData tmp3 = newReg;		HX_STACK_VAR(tmp3,"tmp3");
		HX_STACK_LINE(74)
		::flixel::plugin::MouseEventManager_obj::_registeredObjects->unshift(tmp3);
		HX_STACK_LINE(75)
		Dynamic tmp4 = Object;		HX_STACK_VAR(tmp4,"tmp4");
		HX_STACK_LINE(75)
		return tmp4;
	}
}


STATIC_HX_DEFINE_DYNAMIC_FUNC8(MouseEventManager_obj,add,return )

Dynamic MouseEventManager_obj::remove( Dynamic Object){
	HX_STACK_FRAME("flixel.plugin.MouseEventManager","remove",0x7ba91be3,"flixel.plugin.MouseEventManager.remove","flixel/plugin/MouseEventManager.hx",82,0x4767214f)
	HX_STACK_ARG(Object,"Object")
	HX_STACK_LINE(83)
	{
		HX_STACK_LINE(83)
		int _g = (int)0;		HX_STACK_VAR(_g,"_g");
		HX_STACK_LINE(83)
		Array< ::Dynamic > _g1 = ::flixel::plugin::MouseEventManager_obj::_registeredObjects;		HX_STACK_VAR(_g1,"_g1");
		HX_STACK_LINE(83)
		while((true)){
			HX_STACK_LINE(83)
			bool tmp = (_g < _g1->length);		HX_STACK_VAR(tmp,"tmp");
			HX_STACK_LINE(83)
			bool tmp1 = !(tmp);		HX_STACK_VAR(tmp1,"tmp1");
			HX_STACK_LINE(83)
			if ((tmp1)){
				HX_STACK_LINE(83)
				break;
			}
			HX_STACK_LINE(83)
			::flixel::plugin::_MouseEventManager::ObjectMouseData tmp2 = _g1->__get(_g).StaticCast< ::flixel::plugin::_MouseEventManager::ObjectMouseData >();		HX_STACK_VAR(tmp2,"tmp2");
			HX_STACK_LINE(83)
			::flixel::plugin::_MouseEventManager::ObjectMouseData reg = tmp2;		HX_STACK_VAR(reg,"reg");
			HX_STACK_LINE(83)
			++(_g);
			HX_STACK_LINE(85)
			bool tmp3 = (reg->object == Object);		HX_STACK_VAR(tmp3,"tmp3");
			HX_STACK_LINE(85)
			if ((tmp3)){
				HX_STACK_LINE(87)
				reg->object = null();
				HX_STACK_LINE(88)
				reg->sprite = null();
				HX_STACK_LINE(89)
				reg->onMouseDown = null();
				HX_STACK_LINE(90)
				reg->onMouseUp = null();
				HX_STACK_LINE(91)
				reg->onMouseOver = null();
				HX_STACK_LINE(92)
				reg->onMouseOut = null();
				HX_STACK_LINE(93)
				::flixel::plugin::_MouseEventManager::ObjectMouseData tmp4 = reg;		HX_STACK_VAR(tmp4,"tmp4");
				HX_STACK_LINE(93)
				::flixel::plugin::MouseEventManager_obj::_registeredObjects->remove(tmp4);
			}
		}
	}
	HX_STACK_LINE(96)
	Dynamic tmp = Object;		HX_STACK_VAR(tmp,"tmp");
	HX_STACK_LINE(96)
	return tmp;
}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(MouseEventManager_obj,remove,return )

Void MouseEventManager_obj::reorder( ){
{
		HX_STACK_FRAME("flixel.plugin.MouseEventManager","reorder",0xe10a6f7c,"flixel.plugin.MouseEventManager.reorder","flixel/plugin/MouseEventManager.hx",107,0x4767214f)
		HX_STACK_LINE(108)
		Array< ::Dynamic > orderedObjects = Array_obj< ::Dynamic >::__new();		HX_STACK_VAR(orderedObjects,"orderedObjects");
		HX_STACK_LINE(109)
		::flixel::FlxGame tmp = ::flixel::FlxG_obj::game;		HX_STACK_VAR(tmp,"tmp");
		HX_STACK_LINE(109)
		Array< ::Dynamic > group = tmp->_state->members;		HX_STACK_VAR(group,"group");
		HX_STACK_LINE(111)
		::flixel::FlxGame tmp1 = ::flixel::FlxG_obj::game;		HX_STACK_VAR(tmp1,"tmp1");
		HX_STACK_LINE(111)
		::flixel::FlxState tmp2 = tmp1->_state;		HX_STACK_VAR(tmp2,"tmp2");
		HX_STACK_LINE(111)
		::flixel::plugin::MouseEventManager_obj::traverseFlxGroup(tmp2,orderedObjects);
		HX_STACK_LINE(113)
		orderedObjects->reverse();
		HX_STACK_LINE(114)
		::flixel::plugin::MouseEventManager_obj::_registeredObjects = orderedObjects;
	}
return null();
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(MouseEventManager_obj,reorder,(void))

Void MouseEventManager_obj::setMouseDownCallback( Dynamic Object,Dynamic OnMouseDown){
{
		HX_STACK_FRAME("flixel.plugin.MouseEventManager","setMouseDownCallback",0xe5b0ebe9,"flixel.plugin.MouseEventManager.setMouseDownCallback","flixel/plugin/MouseEventManager.hx",123,0x4767214f)
		HX_STACK_ARG(Object,"Object")
		HX_STACK_ARG(OnMouseDown,"OnMouseDown")
		HX_STACK_LINE(124)
		Dynamic tmp = Object;		HX_STACK_VAR(tmp,"tmp");
		HX_STACK_LINE(124)
		::flixel::plugin::_MouseEventManager::ObjectMouseData tmp1 = ::flixel::plugin::MouseEventManager_obj::getRegister(tmp,null());		HX_STACK_VAR(tmp1,"tmp1");
		HX_STACK_LINE(124)
		::flixel::plugin::_MouseEventManager::ObjectMouseData reg = tmp1;		HX_STACK_VAR(reg,"reg");
		HX_STACK_LINE(126)
		bool tmp2 = (reg != null());		HX_STACK_VAR(tmp2,"tmp2");
		HX_STACK_LINE(126)
		if ((tmp2)){
			HX_STACK_LINE(128)
			reg->onMouseDown = OnMouseDown;
		}
	}
return null();
}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(MouseEventManager_obj,setMouseDownCallback,(void))

Void MouseEventManager_obj::setMouseUpCallback( Dynamic Object,Dynamic OnMouseUp){
{
		HX_STACK_FRAME("flixel.plugin.MouseEventManager","setMouseUpCallback",0x9c77ee62,"flixel.plugin.MouseEventManager.setMouseUpCallback","flixel/plugin/MouseEventManager.hx",138,0x4767214f)
		HX_STACK_ARG(Object,"Object")
		HX_STACK_ARG(OnMouseUp,"OnMouseUp")
		HX_STACK_LINE(139)
		Dynamic tmp = Object;		HX_STACK_VAR(tmp,"tmp");
		HX_STACK_LINE(139)
		::flixel::plugin::_MouseEventManager::ObjectMouseData tmp1 = ::flixel::plugin::MouseEventManager_obj::getRegister(tmp,null());		HX_STACK_VAR(tmp1,"tmp1");
		HX_STACK_LINE(139)
		::flixel::plugin::_MouseEventManager::ObjectMouseData reg = tmp1;		HX_STACK_VAR(reg,"reg");
		HX_STACK_LINE(141)
		bool tmp2 = (reg != null());		HX_STACK_VAR(tmp2,"tmp2");
		HX_STACK_LINE(141)
		if ((tmp2)){
			HX_STACK_LINE(143)
			reg->onMouseUp = OnMouseUp;
		}
	}
return null();
}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(MouseEventManager_obj,setMouseUpCallback,(void))

Void MouseEventManager_obj::setMouseOverCallback( Dynamic Object,Dynamic OnMouseOver){
{
		HX_STACK_FRAME("flixel.plugin.MouseEventManager","setMouseOverCallback",0x0588c6db,"flixel.plugin.MouseEventManager.setMouseOverCallback","flixel/plugin/MouseEventManager.hx",153,0x4767214f)
		HX_STACK_ARG(Object,"Object")
		HX_STACK_ARG(OnMouseOver,"OnMouseOver")
		HX_STACK_LINE(154)
		Dynamic tmp = Object;		HX_STACK_VAR(tmp,"tmp");
		HX_STACK_LINE(154)
		::flixel::plugin::_MouseEventManager::ObjectMouseData tmp1 = ::flixel::plugin::MouseEventManager_obj::getRegister(tmp,null());		HX_STACK_VAR(tmp1,"tmp1");
		HX_STACK_LINE(154)
		::flixel::plugin::_MouseEventManager::ObjectMouseData reg = tmp1;		HX_STACK_VAR(reg,"reg");
		HX_STACK_LINE(156)
		bool tmp2 = (reg != null());		HX_STACK_VAR(tmp2,"tmp2");
		HX_STACK_LINE(156)
		if ((tmp2)){
			HX_STACK_LINE(158)
			reg->onMouseOver = OnMouseOver;
		}
	}
return null();
}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(MouseEventManager_obj,setMouseOverCallback,(void))

Void MouseEventManager_obj::setMouseOutCallback( Dynamic Object,Dynamic OnMouseOut){
{
		HX_STACK_FRAME("flixel.plugin.MouseEventManager","setMouseOutCallback",0xae3f9311,"flixel.plugin.MouseEventManager.setMouseOutCallback","flixel/plugin/MouseEventManager.hx",168,0x4767214f)
		HX_STACK_ARG(Object,"Object")
		HX_STACK_ARG(OnMouseOut,"OnMouseOut")
		HX_STACK_LINE(169)
		Dynamic tmp = Object;		HX_STACK_VAR(tmp,"tmp");
		HX_STACK_LINE(169)
		::flixel::plugin::_MouseEventManager::ObjectMouseData tmp1 = ::flixel::plugin::MouseEventManager_obj::getRegister(tmp,null());		HX_STACK_VAR(tmp1,"tmp1");
		HX_STACK_LINE(169)
		::flixel::plugin::_MouseEventManager::ObjectMouseData reg = tmp1;		HX_STACK_VAR(reg,"reg");
		HX_STACK_LINE(171)
		bool tmp2 = (reg != null());		HX_STACK_VAR(tmp2,"tmp2");
		HX_STACK_LINE(171)
		if ((tmp2)){
			HX_STACK_LINE(173)
			reg->onMouseOut = OnMouseOut;
		}
	}
return null();
}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(MouseEventManager_obj,setMouseOutCallback,(void))

Void MouseEventManager_obj::setObjectMouseEnabled( Dynamic Object,bool MouseEnabled){
{
		HX_STACK_FRAME("flixel.plugin.MouseEventManager","setObjectMouseEnabled",0x435dfdbe,"flixel.plugin.MouseEventManager.setObjectMouseEnabled","flixel/plugin/MouseEventManager.hx",183,0x4767214f)
		HX_STACK_ARG(Object,"Object")
		HX_STACK_ARG(MouseEnabled,"MouseEnabled")
		HX_STACK_LINE(184)
		Dynamic tmp = Object;		HX_STACK_VAR(tmp,"tmp");
		HX_STACK_LINE(184)
		::flixel::plugin::_MouseEventManager::ObjectMouseData tmp1 = ::flixel::plugin::MouseEventManager_obj::getRegister(tmp,null());		HX_STACK_VAR(tmp1,"tmp1");
		HX_STACK_LINE(184)
		::flixel::plugin::_MouseEventManager::ObjectMouseData reg = tmp1;		HX_STACK_VAR(reg,"reg");
		HX_STACK_LINE(186)
		bool tmp2 = (reg != null());		HX_STACK_VAR(tmp2,"tmp2");
		HX_STACK_LINE(186)
		if ((tmp2)){
			HX_STACK_LINE(188)
			reg->mouseEnabled = MouseEnabled;
		}
	}
return null();
}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(MouseEventManager_obj,setObjectMouseEnabled,(void))

bool MouseEventManager_obj::isObjectMouseEnabled( Dynamic Object){
	HX_STACK_FRAME("flixel.plugin.MouseEventManager","isObjectMouseEnabled",0x6b5d7ca4,"flixel.plugin.MouseEventManager.isObjectMouseEnabled","flixel/plugin/MouseEventManager.hx",196,0x4767214f)
	HX_STACK_ARG(Object,"Object")
	HX_STACK_LINE(197)
	Dynamic tmp = Object;		HX_STACK_VAR(tmp,"tmp");
	HX_STACK_LINE(197)
	::flixel::plugin::_MouseEventManager::ObjectMouseData tmp1 = ::flixel::plugin::MouseEventManager_obj::getRegister(tmp,null());		HX_STACK_VAR(tmp1,"tmp1");
	HX_STACK_LINE(197)
	::flixel::plugin::_MouseEventManager::ObjectMouseData reg = tmp1;		HX_STACK_VAR(reg,"reg");
	HX_STACK_LINE(199)
	bool tmp2 = (reg != null());		HX_STACK_VAR(tmp2,"tmp2");
	HX_STACK_LINE(199)
	if ((tmp2)){
		HX_STACK_LINE(201)
		bool tmp3 = reg->mouseEnabled;		HX_STACK_VAR(tmp3,"tmp3");
		HX_STACK_LINE(201)
		return tmp3;
	}
	else{
		HX_STACK_LINE(205)
		return false;
	}
	HX_STACK_LINE(199)
	return false;
}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(MouseEventManager_obj,isObjectMouseEnabled,return )

Void MouseEventManager_obj::setObjectMouseChildren( Dynamic Object,bool MouseChildren){
{
		HX_STACK_FRAME("flixel.plugin.MouseEventManager","setObjectMouseChildren",0x32973562,"flixel.plugin.MouseEventManager.setObjectMouseChildren","flixel/plugin/MouseEventManager.hx",215,0x4767214f)
		HX_STACK_ARG(Object,"Object")
		HX_STACK_ARG(MouseChildren,"MouseChildren")
		HX_STACK_LINE(216)
		Dynamic tmp = Object;		HX_STACK_VAR(tmp,"tmp");
		HX_STACK_LINE(216)
		::flixel::plugin::_MouseEventManager::ObjectMouseData tmp1 = ::flixel::plugin::MouseEventManager_obj::getRegister(tmp,null());		HX_STACK_VAR(tmp1,"tmp1");
		HX_STACK_LINE(216)
		::flixel::plugin::_MouseEventManager::ObjectMouseData reg = tmp1;		HX_STACK_VAR(reg,"reg");
		HX_STACK_LINE(218)
		bool tmp2 = (reg != null());		HX_STACK_VAR(tmp2,"tmp2");
		HX_STACK_LINE(218)
		if ((tmp2)){
			HX_STACK_LINE(220)
			reg->mouseChildren = MouseChildren;
		}
	}
return null();
}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(MouseEventManager_obj,setObjectMouseChildren,(void))

bool MouseEventManager_obj::isObjectMouseChildren( Dynamic Object){
	HX_STACK_FRAME("flixel.plugin.MouseEventManager","isObjectMouseChildren",0x0a26bfbc,"flixel.plugin.MouseEventManager.isObjectMouseChildren","flixel/plugin/MouseEventManager.hx",228,0x4767214f)
	HX_STACK_ARG(Object,"Object")
	HX_STACK_LINE(229)
	Dynamic tmp = Object;		HX_STACK_VAR(tmp,"tmp");
	HX_STACK_LINE(229)
	::flixel::plugin::_MouseEventManager::ObjectMouseData tmp1 = ::flixel::plugin::MouseEventManager_obj::getRegister(tmp,null());		HX_STACK_VAR(tmp1,"tmp1");
	HX_STACK_LINE(229)
	::flixel::plugin::_MouseEventManager::ObjectMouseData reg = tmp1;		HX_STACK_VAR(reg,"reg");
	HX_STACK_LINE(231)
	bool tmp2 = (reg != null());		HX_STACK_VAR(tmp2,"tmp2");
	HX_STACK_LINE(231)
	if ((tmp2)){
		HX_STACK_LINE(233)
		bool tmp3 = reg->mouseChildren;		HX_STACK_VAR(tmp3,"tmp3");
		HX_STACK_LINE(233)
		return tmp3;
	}
	else{
		HX_STACK_LINE(237)
		::openfl::errors::Error tmp3 = ::openfl::errors::Error_obj::__new(HX_HCSTRING("MouseEventManager , isObjectMouseChildren() : object not found","\x5a","\xa8","\x0d","\x42"),null());		HX_STACK_VAR(tmp3,"tmp3");
		HX_STACK_LINE(237)
		HX_STACK_DO_THROW(tmp3);
	}
	HX_STACK_LINE(231)
	return false;
}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(MouseEventManager_obj,isObjectMouseChildren,return )

Void MouseEventManager_obj::traverseFlxGroup( ::flixel::group::FlxGroup Group,Array< ::Dynamic > OrderedObjects){
{
		HX_STACK_FRAME("flixel.plugin.MouseEventManager","traverseFlxGroup",0xc9d3199e,"flixel.plugin.MouseEventManager.traverseFlxGroup","flixel/plugin/MouseEventManager.hx",243,0x4767214f)
		HX_STACK_ARG(Group,"Group")
		HX_STACK_ARG(OrderedObjects,"OrderedObjects")
		HX_STACK_LINE(243)
		int _g = (int)0;		HX_STACK_VAR(_g,"_g");
		HX_STACK_LINE(243)
		Array< ::Dynamic > _g1 = Group->members;		HX_STACK_VAR(_g1,"_g1");
		HX_STACK_LINE(243)
		while((true)){
			HX_STACK_LINE(243)
			bool tmp = (_g < _g1->length);		HX_STACK_VAR(tmp,"tmp");
			HX_STACK_LINE(243)
			bool tmp1 = !(tmp);		HX_STACK_VAR(tmp1,"tmp1");
			HX_STACK_LINE(243)
			if ((tmp1)){
				HX_STACK_LINE(243)
				break;
			}
			HX_STACK_LINE(243)
			::flixel::FlxBasic tmp2 = _g1->__get(_g).StaticCast< ::flixel::FlxBasic >();		HX_STACK_VAR(tmp2,"tmp2");
			HX_STACK_LINE(243)
			::flixel::FlxBasic basic = tmp2;		HX_STACK_VAR(basic,"basic");
			HX_STACK_LINE(243)
			++(_g);
			HX_STACK_LINE(245)
			::flixel::FlxBasic tmp3 = basic;		HX_STACK_VAR(tmp3,"tmp3");
			HX_STACK_LINE(245)
			bool tmp4 = ::Std_obj::is(tmp3,hx::ClassOf< ::flixel::group::FlxGroup >());		HX_STACK_VAR(tmp4,"tmp4");
			HX_STACK_LINE(245)
			if ((tmp4)){
				HX_STACK_LINE(247)
				::flixel::group::FlxGroup tmp5;		HX_STACK_VAR(tmp5,"tmp5");
				HX_STACK_LINE(247)
				tmp5 = hx::TCast< ::flixel::group::FlxGroup >::cast(basic);
				HX_STACK_LINE(247)
				::flixel::plugin::MouseEventManager_obj::traverseFlxGroup(tmp5,OrderedObjects);
			}
			HX_STACK_LINE(250)
			::flixel::FlxBasic tmp5 = basic;		HX_STACK_VAR(tmp5,"tmp5");
			HX_STACK_LINE(250)
			bool tmp6 = ::Std_obj::is(tmp5,hx::ClassOf< ::flixel::FlxSprite >());		HX_STACK_VAR(tmp6,"tmp6");
			HX_STACK_LINE(250)
			if ((tmp6)){
				HX_STACK_LINE(252)
				::flixel::FlxSprite tmp7;		HX_STACK_VAR(tmp7,"tmp7");
				HX_STACK_LINE(252)
				tmp7 = hx::TCast< ::flixel::FlxSprite >::cast(basic);
				HX_STACK_LINE(252)
				::flixel::plugin::_MouseEventManager::ObjectMouseData tmp8 = ::flixel::plugin::MouseEventManager_obj::getRegister(tmp7,null());		HX_STACK_VAR(tmp8,"tmp8");
				HX_STACK_LINE(252)
				::flixel::plugin::_MouseEventManager::ObjectMouseData reg = tmp8;		HX_STACK_VAR(reg,"reg");
				HX_STACK_LINE(254)
				bool tmp9 = (reg != null());		HX_STACK_VAR(tmp9,"tmp9");
				HX_STACK_LINE(254)
				if ((tmp9)){
					HX_STACK_LINE(256)
					::flixel::plugin::_MouseEventManager::ObjectMouseData tmp10 = reg;		HX_STACK_VAR(tmp10,"tmp10");
					HX_STACK_LINE(256)
					OrderedObjects->push(tmp10);
				}
			}
		}
	}
return null();
}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(MouseEventManager_obj,traverseFlxGroup,(void))

::flixel::plugin::_MouseEventManager::ObjectMouseData MouseEventManager_obj::getRegister( Dynamic Object,Array< ::Dynamic > Register){
	HX_STACK_FRAME("flixel.plugin.MouseEventManager","getRegister",0x9104e91a,"flixel.plugin.MouseEventManager.getRegister","flixel/plugin/MouseEventManager.hx",263,0x4767214f)
	HX_STACK_ARG(Object,"Object")
	HX_STACK_ARG(Register,"Register")
	HX_STACK_LINE(264)
	bool tmp = (Register == null());		HX_STACK_VAR(tmp,"tmp");
	HX_STACK_LINE(264)
	if ((tmp)){
		HX_STACK_LINE(266)
		Register = ::flixel::plugin::MouseEventManager_obj::_registeredObjects;
	}
	HX_STACK_LINE(269)
	{
		HX_STACK_LINE(269)
		int _g = (int)0;		HX_STACK_VAR(_g,"_g");
		HX_STACK_LINE(269)
		while((true)){
			HX_STACK_LINE(269)
			bool tmp1 = (_g < Register->length);		HX_STACK_VAR(tmp1,"tmp1");
			HX_STACK_LINE(269)
			bool tmp2 = !(tmp1);		HX_STACK_VAR(tmp2,"tmp2");
			HX_STACK_LINE(269)
			if ((tmp2)){
				HX_STACK_LINE(269)
				break;
			}
			HX_STACK_LINE(269)
			::flixel::plugin::_MouseEventManager::ObjectMouseData tmp3 = Register->__get(_g).StaticCast< ::flixel::plugin::_MouseEventManager::ObjectMouseData >();		HX_STACK_VAR(tmp3,"tmp3");
			HX_STACK_LINE(269)
			::flixel::plugin::_MouseEventManager::ObjectMouseData reg = tmp3;		HX_STACK_VAR(reg,"reg");
			HX_STACK_LINE(269)
			++(_g);
			HX_STACK_LINE(271)
			bool tmp4 = (reg->object == Object);		HX_STACK_VAR(tmp4,"tmp4");
			HX_STACK_LINE(271)
			if ((tmp4)){
				HX_STACK_LINE(273)
				::flixel::plugin::_MouseEventManager::ObjectMouseData tmp5 = reg;		HX_STACK_VAR(tmp5,"tmp5");
				HX_STACK_LINE(273)
				return tmp5;
			}
		}
	}
	HX_STACK_LINE(277)
	return null();
}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(MouseEventManager_obj,getRegister,return )


MouseEventManager_obj::MouseEventManager_obj()
{
}

Dynamic MouseEventManager_obj::__Field(const ::String &inName,hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"update") ) { return update_dyn(); }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"destroy") ) { return destroy_dyn(); }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"checkOverlap") ) { return checkOverlap_dyn(); }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"clearRegistry") ) { return clearRegistry_dyn(); }
		break;
	case 21:
		if (HX_FIELD_EQ(inName,"checkOverlapWithPoint") ) { return checkOverlapWithPoint_dyn(); }
		break;
	case 24:
		if (HX_FIELD_EQ(inName,"checkPixelPerfectOverlap") ) { return checkPixelPerfectOverlap_dyn(); }
	}
	return super::__Field(inName,inCallProp);
}

bool MouseEventManager_obj::__GetStatic(const ::String &inName, Dynamic &outValue, hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 3:
		if (HX_FIELD_EQ(inName,"add") ) { outValue = add_dyn(); return true;  }
		break;
	case 4:
		if (HX_FIELD_EQ(inName,"init") ) { outValue = init_dyn(); return true;  }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"_point") ) { outValue = _point; return true;  }
		if (HX_FIELD_EQ(inName,"remove") ) { outValue = remove_dyn(); return true;  }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"reorder") ) { outValue = reorder_dyn(); return true;  }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"getRegister") ) { outValue = getRegister_dyn(); return true;  }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"traverseFlxGroup") ) { outValue = traverseFlxGroup_dyn(); return true;  }
		break;
	case 17:
		if (HX_FIELD_EQ(inName,"_mouseOverObjects") ) { outValue = _mouseOverObjects; return true;  }
		break;
	case 18:
		if (HX_FIELD_EQ(inName,"_registeredObjects") ) { outValue = _registeredObjects; return true;  }
		if (HX_FIELD_EQ(inName,"setMouseUpCallback") ) { outValue = setMouseUpCallback_dyn(); return true;  }
		break;
	case 19:
		if (HX_FIELD_EQ(inName,"setMouseOutCallback") ) { outValue = setMouseOutCallback_dyn(); return true;  }
		break;
	case 20:
		if (HX_FIELD_EQ(inName,"setMouseDownCallback") ) { outValue = setMouseDownCallback_dyn(); return true;  }
		if (HX_FIELD_EQ(inName,"setMouseOverCallback") ) { outValue = setMouseOverCallback_dyn(); return true;  }
		if (HX_FIELD_EQ(inName,"isObjectMouseEnabled") ) { outValue = isObjectMouseEnabled_dyn(); return true;  }
		break;
	case 21:
		if (HX_FIELD_EQ(inName,"setObjectMouseEnabled") ) { outValue = setObjectMouseEnabled_dyn(); return true;  }
		if (HX_FIELD_EQ(inName,"isObjectMouseChildren") ) { outValue = isObjectMouseChildren_dyn(); return true;  }
		break;
	case 22:
		if (HX_FIELD_EQ(inName,"setObjectMouseChildren") ) { outValue = setObjectMouseChildren_dyn(); return true;  }
	}
	return false;
}

bool MouseEventManager_obj::__SetStatic(const ::String &inName,Dynamic &ioValue,hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"_point") ) { _point=ioValue.Cast< ::flixel::util::FlxPoint >(); return true; }
		break;
	case 17:
		if (HX_FIELD_EQ(inName,"_mouseOverObjects") ) { _mouseOverObjects=ioValue.Cast< Array< ::Dynamic > >(); return true; }
		break;
	case 18:
		if (HX_FIELD_EQ(inName,"_registeredObjects") ) { _registeredObjects=ioValue.Cast< Array< ::Dynamic > >(); return true; }
	}
	return false;
}

#if HXCPP_SCRIPTABLE
static hx::StorageInfo *sMemberStorageInfo = 0;
static hx::StaticInfo sStaticStorageInfo[] = {
	{hx::fsObject /*Array< ::Dynamic >*/ ,(void *) &MouseEventManager_obj::_registeredObjects,HX_HCSTRING("_registeredObjects","\x33","\x2c","\xb1","\xfd")},
	{hx::fsObject /*Array< ::Dynamic >*/ ,(void *) &MouseEventManager_obj::_mouseOverObjects,HX_HCSTRING("_mouseOverObjects","\x1a","\x9a","\x98","\xa8")},
	{hx::fsObject /*::flixel::util::FlxPoint*/ ,(void *) &MouseEventManager_obj::_point,HX_HCSTRING("_point","\x91","\xfb","\x76","\xc2")},
	{ hx::fsUnknown, 0, null()}
};
#endif

static ::String sMemberFields[] = {
	HX_HCSTRING("destroy","\xfa","\x2c","\x86","\x24"),
	HX_HCSTRING("update","\x09","\x86","\x05","\x87"),
	HX_HCSTRING("clearRegistry","\x6a","\xb4","\xfc","\x03"),
	HX_HCSTRING("checkOverlap","\x9f","\xfb","\x96","\x96"),
	HX_HCSTRING("checkOverlapWithPoint","\xcb","\x10","\xc2","\x44"),
	HX_HCSTRING("checkPixelPerfectOverlap","\x38","\x87","\xe1","\x62"),
	::String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(MouseEventManager_obj::__mClass,"__mClass");
	HX_MARK_MEMBER_NAME(MouseEventManager_obj::_registeredObjects,"_registeredObjects");
	HX_MARK_MEMBER_NAME(MouseEventManager_obj::_mouseOverObjects,"_mouseOverObjects");
	HX_MARK_MEMBER_NAME(MouseEventManager_obj::_point,"_point");
};

#ifdef HXCPP_VISIT_ALLOCS
static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(MouseEventManager_obj::__mClass,"__mClass");
	HX_VISIT_MEMBER_NAME(MouseEventManager_obj::_registeredObjects,"_registeredObjects");
	HX_VISIT_MEMBER_NAME(MouseEventManager_obj::_mouseOverObjects,"_mouseOverObjects");
	HX_VISIT_MEMBER_NAME(MouseEventManager_obj::_point,"_point");
};

#endif

hx::Class MouseEventManager_obj::__mClass;

static ::String sStaticFields[] = {
	HX_HCSTRING("_registeredObjects","\x33","\x2c","\xb1","\xfd"),
	HX_HCSTRING("_mouseOverObjects","\x1a","\x9a","\x98","\xa8"),
	HX_HCSTRING("_point","\x91","\xfb","\x76","\xc2"),
	HX_HCSTRING("init","\x10","\x3b","\xbb","\x45"),
	HX_HCSTRING("add","\x21","\xf2","\x49","\x00"),
	HX_HCSTRING("remove","\x44","\x9c","\x88","\x04"),
	HX_HCSTRING("reorder","\xfb","\x43","\xbb","\x1b"),
	HX_HCSTRING("setMouseDownCallback","\x0a","\xf4","\x07","\xda"),
	HX_HCSTRING("setMouseUpCallback","\x43","\xfc","\x86","\x24"),
	HX_HCSTRING("setMouseOverCallback","\xfc","\xce","\xdf","\xf9"),
	HX_HCSTRING("setMouseOutCallback","\x10","\xaa","\x5c","\x33"),
	HX_HCSTRING("setObjectMouseEnabled","\x7d","\x12","\x2e","\x1b"),
	HX_HCSTRING("isObjectMouseEnabled","\xc5","\x84","\xb4","\x5f"),
	HX_HCSTRING("setObjectMouseChildren","\xc3","\x47","\xd9","\x30"),
	HX_HCSTRING("isObjectMouseChildren","\x7b","\xd4","\xf6","\xe1"),
	HX_HCSTRING("traverseFlxGroup","\x3f","\x3d","\x59","\xc9"),
	HX_HCSTRING("getRegister","\x19","\x69","\x93","\xf6"),
	::String(null()) };

void MouseEventManager_obj::__register()
{
	hx::Static(__mClass) = new hx::Class_obj();
	__mClass->mName = HX_HCSTRING("flixel.plugin.MouseEventManager","\xef","\xa2","\x6b","\xe7");
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &MouseEventManager_obj::__GetStatic;
	__mClass->mSetStaticField = &MouseEventManager_obj::__SetStatic;
	__mClass->mMarkFunc = sMarkStatics;
	__mClass->mStatics = hx::Class_obj::dupFunctions(sStaticFields);
	__mClass->mMembers = hx::Class_obj::dupFunctions(sMemberFields);
	__mClass->mCanCast = hx::TCanCast< MouseEventManager_obj >;
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

} // end namespace flixel
} // end namespace plugin
