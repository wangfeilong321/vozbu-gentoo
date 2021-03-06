# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit cmake-utils subversion

ESVN_REPO_URI="http://www.openscenegraph.org/svn/osg/OpenSceneGraph/trunk"

DESCRIPTION="Open source high performance 3D graphics toolkit"
HOMEPAGE="http://www.openscenegraph.org/projects/osg/"
SLOT="0"
LICENSE="wxWinLL-3 LGPL-2.1"
KEYWORDS="~amd64 ~x86"
IUSE="collada curl doc examples gif jpeg jpeg2k osgapps pdf png svg tiff truetype vnc xine xrandr xulrunner"

RDEPEND="virtual/opengl
	virtual/glu
	x11-libs/libSM
	x11-libs/libXext
	collada? ( >=media-libs/collada-dom-2.1 )
	curl? ( net-misc/curl )
	gif? ( media-libs/giflib )
	jpeg? ( media-libs/jpeg )
	jpeg2k? ( media-libs/jasper )
	pdf? ( virtual/poppler-glib[cairo] )
	png? ( media-libs/libpng )
	svg? ( gnome-base/librsvg )
	tiff? ( media-libs/tiff )
	truetype? ( media-libs/freetype:2 )
	vnc? ( net-libs/libvncserver )
	xine? ( media-libs/xine-lib )
	xrandr? ( x11-libs/libXrandr )
	xulrunner? ( net-libs/xulrunner )
	"
DEPEND="${RDEPEND}
	app-arch/unzip
	doc? ( app-doc/doxygen )"

src_configure() {
	mycmakeargs="-DOSG_USE_REF_PTR_IMPLICIT_OUTPUT_CONVERSION:BOOL=OFF"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use doc BUILD_DOCUMENTATION)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use examples BUILD_OSG_EXAMPLES)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use osgapps BUILD_OSG_APPLICATIONS)"
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	use doc && cmake-utils_src_compile doc_openscenegraph
	use doc && cmake-utils_src_compile doc_openthreads
}

src_install() {
	cmake-utils_src_install
	use doc && dosym /usr/doc/OpenSceneGraphReferenceDocs /usr/share/doc/${PF}/html
	insinto "/usr/lib/pkgconfig"
	doins packaging/pkgconfig/openthreads.pc
	doins packaging/pkgconfig/openscenegraph.pc
}
