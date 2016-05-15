#include <hxcpp.h>

#ifndef INCLUDED_flixel_FlxBasic
#include <flixel/FlxBasic.h>
#endif
#ifndef INCLUDED_flixel_FlxObject
#include <flixel/FlxObject.h>
#endif
#ifndef INCLUDED_flixel_FlxSprite
#include <flixel/FlxSprite.h>
#endif
#ifndef INCLUDED_flixel_interfaces_IFlxDestroyable
#include <flixel/interfaces/IFlxDestroyable.h>
#endif
#ifndef INCLUDED_flixel_plugin__MouseEventManager_ObjectMouseData
#include <flixel/plugin/_MouseEventManager/ObjectMouseData.h>
#endif
namespace flixel{
namespace plugin{
namespace _MouseEventManager{

Void ObjectMouseData_obj::__construct(Dynamic object,Dynamic onMouseDown,Dynamic onMouseUp,Dynamic onMouseOver,Dynamic onMouseOut,bool mouseChildren,bool mouseEnabled,bool pixelPerfect)
{
HX_STACK_FRAME("flixel.plugin._MouseEventManager.ObjectMouseData","new",0xb9603eb6,"flixel.plugin._MouseEventManager.ObjectMouseData.new","flixel/plugin/MouseEventManager.hx",464,0x4767214f)
HX_STACK_THIS(this)
HX_STACK_ARG(object,"object")
HX_STACK_ARG(onMouseDown,"onMouseDown")
HX_STACK_ARG(onMouseUp,"onMouseUp")
HX_STACK_ARG(onMouseOver,"onMouseOver")
HX_STACK_ARG(onMouseOut,"onMouseOut")
HX_STACK_ARG(mouseChildren,"mouseChildren")
HX_STACK_ARG(mouseEnabled,"mouseEnabled")
HX_STACK_ARG(pixelPerfect,"pixelPerfect")
{
	HX_STACK_LINE(465)
	this->object = object;
	HX_STACK_LINE(466)
	this->onMouseDown = onMouseDown;
	HX_STACK_LINE(467)
	this->onMouseUp = onMouseUp;
	HX_STACK_LINE(468)
	this->onMouseOver = onMouseOver;
	HX_STACK_LINE(469)
	this->onMouseOut = onMouseOut;
	HX_STACK_LINE(470)
	this->mouseChildren = mouseChildren;
	HX_STACK_LINE(471)
	this->mouseEnabled = mouseEnabled;
	HX_STACK_LINE(472)
	this->pixelPerfect = pixelPerfect;
}
;
	return null();
}

//ObjectMouseData_obj::~ObjectMouseData_obj() { }

Dynamic ObjectMouseData_obj::__CreateEmpty() { return  new ObjectMouseData_obj; }
hx::ObjectPtr< ObjectMouseData_obj > ObjectMouseData_obj::__new(Dynamic object,Dynamic onMouseDown,Dynamic onMouseUp,Dynamic onMouseOver,Dynamic onMouseOut,bool mouseChildren,bool mouseEnabled,bool pixelPerfect)
{  hx::ObjectPtr< ObjectMouseData_obj > _result_ = new ObjectMouseData_obj();
	_result_->__construct(object,onMouseDown,onMouseUp,onMouseOver,onMouseOut,mouseChildren,mouseEnabled,pixelPerfect);
	return _result_;}

Dynamic ObjectMouseData_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< ObjectMouseData_obj > _result_ = new ObjectMouseData_obj();
	_result_->__construct(inArgs[0],inArgs[1],inArgs[2],inArgs[3],inArgs[4],inArgs[5],inArgs[6],inArgs[7]);
	return _result_;}


ObjectMouseData_obj::ObjectMouseData_obj()
{
}

void ObjectMouseData_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(ObjectMouseData);
	HX_MARK_MEMBER_NAME(object,"object");
	HX_MARK_MEMBER_NAME(onMouseDown,"onMouseDown");
	HX_MARK_MEMBER_NAME(onMouseUp,"onMouseUp");
	HX_MARK_MEMBER_NAME(onMouseOver,"onMouseOver");
	HX_MARK_MEMBER_NAME(onMouseOut,"onMouseOut");
	HX_MARK_MEMBER_NAME(mouseChildren,"mouseChildren");
	HX_MARK_MEMBER_NAME(mouseEnabled,"mouseEnabled");
	HX_MARK_MEMBER_NAME(pixelPerfect,"pixelPerfect");
	HX_MARK_MEMBER_NAME(sprite,"sprite");
	HX_MARK_END_CLASS();
}

void ObjectMouseData_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(object,"object");
	HX_VISIT_MEMBER_NAME(onMouseDown,"onMouseDown");
	HX_VISIT_MEMBER_NAME(onMouseUp,"onMouseUp");
	HX_VISIT_MEMBER_NAME(onMouseOver,"onMouseOver");
	HX_VISIT_MEMBER_NAME(onMouseOut,"onMouseOut");
	HX_VISIT_MEMBER_NAME(mouseChildren,"mouseChildren");
	HX_VISIT_MEMBER_NAME(mouseEnabled,"mouseEnabled");
	HX_VISIT_MEMBER_NAME(pixelPerfect,"pixelPerfect");
	HX_VISIT_MEMBER_NAME(sprite,"sprite");
}

Dynamic ObjectMouseData_obj::__Field(const ::String &inName,hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"object") ) { return object; }
		if (HX_FIELD_EQ(inName,"sprite") ) { return sprite; }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"onMouseUp") ) { return onMouseUp; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"onMouseOut") ) { return onMouseOut; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"onMouseDown") ) { return onMouseDown; }
		if (HX_FIELD_EQ(inName,"onMouseOver") ) { return onMouseOver; }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"mouseEnabled") ) { return mouseEnabled; }
		if (HX_FIELD_EQ(inName,"pixelPerfect") ) { return pixelPerfect; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"mouseChildren") ) { return mouseChildren; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic ObjectMouseData_obj::__SetField(const ::String &inName,const Dynamic &inValue,hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"object") ) { object=inValue.Cast< ::flixel::FlxObject >(); return inValue; }
		if (HX_FIELD_EQ(inName,"sprite") ) { sprite=inValue.Cast< ::flixel::FlxSprite >(); return inValue; }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"onMouseUp") ) { onMouseUp=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"onMouseOut") ) { onMouseOut=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"onMouseDown") ) { onMouseDown=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"onMouseOver") ) { onMouseOver=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"mouseEnabled") ) { mouseEnabled=inValue.Cast< bool >(); return inValue; }
		if (HX_FIELD_EQ(inName,"pixelPerfect") ) { pixelPerfect=inValue.Cast< bool >(); return inValue; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"mouseChildren") ) { mouseChildren=inValue.Cast< bool >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void ObjectMouseData_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_HCSTRING("object","\xbf","\x7e","\x3f","\x15"));
	outFields->push(HX_HCSTRING("mouseChildren","\x84","\x18","\x6b","\xff"));
	outFields->push(HX_HCSTRING("mouseEnabled","\xdc","\x54","\xd6","\x5f"));
	outFields->push(HX_HCSTRING("pixelPerfect","\x27","\x23","\x90","\x64"));
	outFields->push(HX_HCSTRING("sprite","\x05","\xdc","\x95","\xc3"));
	super::__GetFields(outFields);
};

#if HXCPP_SCRIPTABLE
static hx::StorageInfo sMemberStorageInfo[] = {
	{hx::fsObject /*::flixel::FlxObject*/ ,(int)offsetof(ObjectMouseData_obj,object),HX_HCSTRING("object","\xbf","\x7e","\x3f","\x15")},
	{hx::fsObject /*Dynamic*/ ,(int)offsetof(ObjectMouseData_obj,onMouseDown),HX_HCSTRING("onMouseDown","\x08","\x94","\x05","\x11")},
	{hx::fsObject /*Dynamic*/ ,(int)offsetof(ObjectMouseData_obj,onMouseUp),HX_HCSTRING("onMouseUp","\x81","\xac","\x1d","\x98")},
	{hx::fsObject /*Dynamic*/ ,(int)offsetof(ObjectMouseData_obj,onMouseOver),HX_HCSTRING("onMouseOver","\xfa","\x2c","\x50","\x18")},
	{hx::fsObject /*Dynamic*/ ,(int)offsetof(ObjectMouseData_obj,onMouseOut),HX_HCSTRING("onMouseOut","\xa8","\xbb","\xd4","\x81")},
	{hx::fsBool,(int)offsetof(ObjectMouseData_obj,mouseChildren),HX_HCSTRING("mouseChildren","\x84","\x18","\x6b","\xff")},
	{hx::fsBool,(int)offsetof(ObjectMouseData_obj,mouseEnabled),HX_HCSTRING("mouseEnabled","\xdc","\x54","\xd6","\x5f")},
	{hx::fsBool,(int)offsetof(ObjectMouseData_obj,pixelPerfect),HX_HCSTRING("pixelPerfect","\x27","\x23","\x90","\x64")},
	{hx::fsObject /*::flixel::FlxSprite*/ ,(int)offsetof(ObjectMouseData_obj,sprite),HX_HCSTRING("sprite","\x05","\xdc","\x95","\xc3")},
	{ hx::fsUnknown, 0, null()}
};
static hx::StaticInfo *sStaticStorageInfo = 0;
#endif

static ::String sMemberFields[] = {
	HX_HCSTRING("object","\xbf","\x7e","\x3f","\x15"),
	HX_HCSTRING("onMouseDown","\x08","\x94","\x05","\x11"),
	HX_HCSTRING("onMouseUp","\x81","\xac","\x1d","\x98"),
	HX_HCSTRING("onMouseOver","\xfa","\x2c","\x50","\x18"),
	HX_HCSTRING("onMouseOut","\xa8","\xbb","\xd4","\x81"),
	HX_HCSTRING("mouseChildren","\x84","\x18","\x6b","\xff"),
	HX_HCSTRING("mouseEnabled","\xdc","\x54","\xd6","\x5f"),
	HX_HCSTRING("pixelPerfect","\x27","\x23","\x90","\x64"),
	HX_HCSTRING("sprite","\x05","\xdc","\x95","\xc3"),
	::String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(ObjectMouseData_obj::__mClass,"__mClass");
};

#ifdef HXCPP_VISIT_ALLOCS
static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(ObjectMouseData_obj::__mClass,"__mClass");
};

#endif

hx::Class ObjectMouseData_obj::__mClass;

void ObjectMouseData_obj::__register()
{
	hx::Static(__mClass) = new hx::Class_obj();
	__mClass->mName = HX_HCSTRING("flixel.plugin._MouseEventManager.ObjectMouseData","\xc4","\x6b","\x89","\xe7");
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &hx::Class_obj::GetNoStaticField;
	__mClass->mSetStaticField = &hx::Class_obj::SetNoStaticField;
	__mClass->mMarkFunc = sMarkStatics;
	__mClass->mStatics = hx::Class_obj::dupFunctions(0 /* sStaticFields */);
	__mClass->mMembers = hx::Class_obj::dupFunctions(sMemberFields);
	__mClass->mCanCast = hx::TCanCast< ObjectMouseData_obj >;
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
} // end namespace _MouseEventManager
