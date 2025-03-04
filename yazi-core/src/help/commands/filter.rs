use yazi_config::popup::{Offset, Origin, Position};
use yazi_macro::render;
use yazi_shared::event::CmdCow;

use crate::{help::Help, input::Input};

impl Help {
	pub fn filter(&mut self, _: CmdCow) {
		let mut input = Input::default();
		input.position = Position::new(Origin::BottomLeft, Offset::line());

		self.in_filter = Some(input);
		self.filter_apply();
		render!();
	}
}
